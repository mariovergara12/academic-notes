# notes

My notes on computer science and mathematics, written in Typst.

[Browse the notes](https://mariovergara12.github.io/academic-notes/)

## Adding notes

Put `.typ` files under `notes/`, organized by subject and course:

```text
notes/<subject>/<course>/<optional-topic>/<note>.typ
```

Push to `main` to compile the PDFs and update the site. New subjects and courses
appear automatically once they contain a compiled note. Keep diagrams alongside
the source files; PDFs don't need to be committed.

## Local preview

With Typst and Python 3 installed:

```bash
python3 scripts/build.py
python3 -m http.server 8000 --directory _site
```

Open [localhost:8000](http://localhost:8000/).
