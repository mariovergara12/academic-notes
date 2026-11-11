# Academic Notes

A searchable GitHub Pages library for my computer science and mathematics notes. Typst sources are compiled to PDFs automatically on each push to `main`.

## Setup on a local computer

Clone the repository (the remote repository already exists):

```bash
git clone https://github.com/mariovergara12/academic-notes.git
cd academic-notes
```

Copy your **latest corrected** Typst files into `notes/`, organized by course. A recommended layout:

```text
academic-notes/
├── .github/workflows/publish.yml
├── templates/
│   └── academic.typ
├── notes/
│   ├── dsa/
│   │   ├── 02-trees/
│   │   │   └── 4.4-avl-trees.typ
│   │   ├── 03-heaps/
│   │   └── diagrams/
│   └── differential-equations/
│       ├── 4.6-variation-of-parameters.typ
│       └── ...
├── scripts/build.py
└── website/
```

**Keep diagram locations consistent:** A note such as `notes/dsa/02-trees/4.4-avl-trees.typ` that imports `../diagrams/avl-ll-before.svg` expects that image at `notes/dsa/diagrams/avl-ll-before.svg`.

The included `templates/academic.typ` is a minimal compatibility template, **not** a copy of your customized local template. For the exact formatting you already use, replace it with your own `academic.typ`. The build runs Typst with the repository root set to this directory, so your existing imports such as `#import "/templates/academic.typ": *` work.

Commit and push:

```bash
git add .
git commit -m "Add corrected course notes"
git push origin main
```

## Enable GitHub Pages

On GitHub, go to **Settings → Pages → Build and deployment → Source → GitHub Actions**.

The repository workflow `.github/workflows/publish.yml` automatically:

1. Checks out `main`.
2. Installs Typst.
3. Compiles every `notes/**/*.typ` into a PDF.
4. Generates a searchable index using titles, course names, and Typst source text.
5. Publishes the website via GitHub Pages.

Website: **https://mariovergara12.github.io/academic-notes/**

The searchable index matches **Typst source text**, not text extracted from external PDFs. Notes that fail to compile are omitted from the published index and reported individually in the GitHub Actions job logs and run summary, while successfully compiled PDFs still publish.

## Test locally

Install Typst and Python 3, then run:

```bash
python3 scripts/build.py
python3 -m http.server 8000 --directory _site
```

Visit <http://localhost:8000/>. Each PDF is generated under `_site/pdfs/`.

## Browsing the library

The website is a buildless HTML, CSS, and JavaScript application. The dashboard,
subject collections, course navigation, statistics, and search results all use
the generated `notes.json`; no course lists or note counts are maintained by hand.
Search matches every word against titles, metadata, folder topics, and Typst source
text. Course and topic filters combine with search. The URL preserves the current
collection, filters, and sort order for sharing and browser back/forward navigation.

- Press `/` or `Cmd/Ctrl+K` to focus search.
- Select a note title to view its metadata and PDF preview; `Escape` closes it.
- Use **Open PDF** for a new tab or **Download** to save a copy. Embedded PDF
  rendering depends on the browser; the direct links remain available.
- The theme button switches light/dark mode. The initial theme follows the system;
  explicit choices and the desktop sidebar preference persist in local storage.
- Mobile navigation supports keyboard focus containment, a close button, and Escape.

The original index fields (`title`, `course`, `semester`, `path`, `url`, `search`)
remain compatible. New folders need no registration or website edits. Use:

```text
notes/<subject>/<course>/<optional-topic-folders>/<note>.typ
```

The first folder supplies the subject, the second supplies the default course
name, and deeper folders supply topics. Names with spaces, hyphens, or underscores
are supported. For example, adding notes under `notes/physics/mechanics/`,
`notes/cs/automata/`, or `notes/math/real analysis/` automatically creates the
corresponding subjects, course cards, filters, and sidebar entries on the next
push to `main`. These are examples only; the library displays actual compiled
notes. Empty folders and notes that fail to compile do not create entries.

Quoted Typst metadata such as `course: "Real Analysis"` overrides the folder’s
default display name. Optional `subject`, `topic`, and `category` fields also
provide explicit labels. The existing `dsa/` and `differential-equations/` legacy
layouts remain supported. Courses with the same name in different subjects stay
separate when opened from their subject or course card.

**Recently added** uses each note’s first addition in Git history. The publishing
checkout includes full history for this purpose. When Git history is missing or
shallow, the build omits dates and the dashboard shows **From the library** rather
than claiming those entries are recent. No build timestamp is used as a note date.

Run the data, routing, and build-metadata regression tests (no npm install needed):

```bash
node --test tests/library.test.mjs
python3 -m unittest discover -s tests -p 'test_*.py'
```

The publishing workflow continues to compile Typst and deploy the static `_site/`
directory to GitHub Pages; no frontend framework, service, or build step is required.

## Important

- This is a **public** site and repository. Do not commit private notes or copyrighted textbook scans unless you have permission.
- You do **not** need to commit compiled PDFs; GitHub Actions creates them automatically.
- Keep your corrected local source files and diagrams. Don't replace them with earlier draft ZIPs.
