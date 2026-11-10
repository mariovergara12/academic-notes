// Minimal, portable academic template for GitHub Actions.
// Replace with your own academic.typ to preserve your current local styling.
// No third-party Typst packages required.

#let academic(title: "Untitled", course: "", semester: "", body) = {
  set page(paper: "us-letter", margin: (x: 0.85in, y: 0.82in))
  set text(font: "Libertinus Serif", size: 10.5pt)
  set heading(numbering: "1.1")
  set par(justify: true)

  align(center)[
    #text(size: 19pt, weight: "bold")[#title]
    #v(0.4em)
    #text(size: 10pt, fill: luma(90))[#course]
    #v(0.1em)
    #text(size: 9pt, fill: luma(110))[#semester]
  ]
  v(0.7em)
  line(length: 100%, stroke: 0.55pt + luma(185))
  v(0.8em)
  body
}

#let definition(body) = block(
  width: 100%,
  inset: (left: 10pt, right: 5pt, top: 4pt, bottom: 4pt),
  stroke: (left: 0.8pt + luma(155)),
)[#body]

#let theorem(body) = block(
  width: 100%,
  inset: (left: 10pt, right: 5pt, top: 4pt, bottom: 4pt),
  stroke: (left: 0.8pt + luma(155)),
)[#body]
