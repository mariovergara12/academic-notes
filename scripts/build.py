#!/usr/bin/env python3
"""Compile every note under notes/ and generate a searchable static PDF library."""

import json
import hashlib
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
from datetime import datetime, timezone
from urllib.parse import quote

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "notes"
WEBSITE = ROOT / "website"
OUTPUT = ROOT / "_site"


def metadata(raw: str, key: str, fallback: str) -> str:
    match = re.search(r"\b" + re.escape(key) + r'\s*:\s*"([^"]+)"', raw)
    return match.group(1) if match else fallback


def default_course(rel: Path) -> str:
    """New notes use subject/course/topic/file; retain the known legacy layouts."""
    legacy = {"dsa": "Data Structures & Algorithms", "diffeq": "Differential Equations",
              "differential-equations": "Differential Equations"}
    if rel.parts[0].lower() in legacy:
        return legacy[rel.parts[0].lower()]
    folder = rel.parts[1] if len(rel.parts) > 2 else (rel.parts[0] if len(rel.parts) > 1 else "General")
    return folder.replace("-", " ").replace("_", " ").title()


def version_assets(output: Path) -> dict[str, str]:
    """Keep new HTML from loading cached assets from a previous deployment."""
    versions = {}
    # Dependencies come first: changing library.mjs must also change app.js's URL.
    for name in ("library.mjs", "app.js", "theme.js", "styles.css", "favicon.svg"):
        source = output / name
        content = source.read_text(encoding="utf-8")
        for dependency, versioned in versions.items():
            for quote_mark in ("'", '"'):
                content = content.replace(
                    f"{quote_mark}./{dependency}{quote_mark}",
                    f"{quote_mark}./{versioned}{quote_mark}",
                )
        digest = hashlib.sha256(content.encode("utf-8")).hexdigest()[:16]
        versioned = f"{source.stem}.{digest}{source.suffix}"
        (output / versioned).write_text(content, encoding="utf-8")
        versions[name] = versioned

    index = output / "index.html"
    content = index.read_text(encoding="utf-8")
    for name, versioned in versions.items():
        for quote_mark in ("'", '"'):
            content = content.replace(f"{quote_mark}{name}{quote_mark}", f"{quote_mark}{versioned}{quote_mark}")
    index.write_text(content, encoding="utf-8")
    return versions


def addition_dates() -> dict[str, str]:
    """Read real addition dates. Shallow/source-only checkouts have no reliable history."""
    try:
        shallow = subprocess.run(
            ["git", "rev-parse", "--is-shallow-repository"], cwd=ROOT,
            capture_output=True, text=True, timeout=10, check=True,
        )
        if shallow.stdout.strip() == "true":
            return {}
        history = subprocess.run(
            ["git", "log", "--reverse", "--format=added:%aI", "--name-only",
             "--diff-filter=A", "--", "notes"], cwd=ROOT,
            capture_output=True, text=True, timeout=30, check=True,
        )
    except (OSError, subprocess.SubprocessError):
        return {}
    dates = {}
    current = ""
    for line in history.stdout.splitlines():
        if line.startswith("added:"):
            current = line.removeprefix("added:")
        elif line.startswith("notes/") and current:
            dates.setdefault(line.removeprefix("notes/"), current)
    return dates


def report_to_actions(successes: int, failures: list, total: int) -> None:
    summary = [
        "## Academic notes build",
        "",
        f"- Notes discovered: **{total}**",
        f"- PDFs compiled: **{successes}**",
        f"- Compilation failures: **{len(failures)}**",
    ]
    if failures:
        summary.extend(["", "### Failed notes"])
        for item in failures:
            summary.append(f"- \u0060{item}\u0060")
    text = "\n".join(summary) + "\n"
    print(text)
    if os.getenv("GITHUB_STEP_SUMMARY"):
        with open(os.environ["GITHUB_STEP_SUMMARY"], "a", encoding="utf-8") as fp:
            fp.write(text)


def main() -> int:
    if OUTPUT.exists():
        shutil.rmtree(OUTPUT)
    shutil.copytree(WEBSITE, OUTPUT)
    (OUTPUT / "pdfs").mkdir(parents=True, exist_ok=True)

    documents = []
    failures = []
    added = addition_dates()
    sources = sorted(SOURCE.rglob("*.typ")) if SOURCE.exists() else []

    for source in sources:
        rel = source.relative_to(SOURCE)
        if any(part.startswith(".") for part in rel.parts):
            continue

        raw = source.read_text(encoding="utf-8")
        pdf_rel = rel.with_suffix(".pdf")
        destination = OUTPUT / "pdfs" / pdf_rel
        destination.parent.mkdir(parents=True, exist_ok=True)

        command = [
            "typst", "compile", "--root", str(ROOT),
            str(source), str(destination)
        ]
        try:
            run = subprocess.run(
                command, capture_output=True, text=True,
                timeout=120, check=False
            )
        except (OSError, subprocess.TimeoutExpired) as exc:
            failures.append(str(rel))
            print(f"::warning file={source}::Compilation failed: {exc}", flush=True)
            continue

        if run.returncode != 0:
            failures.append(str(rel))
            print(f"::warning file={source}::Typst compilation failed", flush=True)
            print(run.stderr[-6000:], file=sys.stderr, flush=True)
            destination.unlink(missing_ok=True)
            continue

        title = metadata(raw, "title", rel.stem.replace("-", " ").title())
        course = metadata(raw, "course", default_course(rel))
        semester = metadata(raw, "semester", "")
        text = re.sub(r"(?s)```.*?```", " ", raw)
        text = re.sub(r"\s+", " ", text)

        document = {
            "title": title,
            "course": course,
            "semester": semester,
            "path": rel.as_posix(),
            "url": "pdfs/" + quote(pdf_rel.as_posix(), safe="/"),
            "search": (title + " " + course + " " + semester + " " + text)[:60000],
        }
        if rel.as_posix() in added:
            document["added"] = added[rel.as_posix()]
        # Optional metadata extends the index without changing its existing fields.
        for field in ("subject", "category", "topic"):
            value = metadata(raw, field, "")
            if value:
                document[field] = value
        documents.append(document)
        print(f"Compiled {rel} -> {pdf_rel}", flush=True)

    (OUTPUT / "notes.json").write_text(
        json.dumps({
            "updated": datetime.now(timezone.utc).isoformat(),
            "documents": documents,
            "failed_count": len(failures),
        }, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    (OUTPUT / ".nojekyll").write_text("", encoding="utf-8")
    version_assets(OUTPUT)
    report_to_actions(len(documents), failures, len(sources))
    # Partial failures are explicitly reported; working notes still publish.
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
