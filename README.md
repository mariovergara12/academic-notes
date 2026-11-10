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

## Important

- This is a **public** site and repository. Do not commit private notes or copyrighted textbook scans unless you have permission.
- You do **not** need to commit compiled PDFs; GitHub Actions creates them automatically.
- Keep your corrected local source files and diagrams. Don't replace them with earlier draft ZIPs.
