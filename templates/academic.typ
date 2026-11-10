#let navy = rgb("#1E3A5F")
#let blue = rgb("#2563A6")
#let muted = rgb("#64748B")

#let academic(
  title: "Lecture Notes",
  course: "Mathematics",
  semester: "Fall 2026",
  body,
) = {
  set page(
    paper: "us-letter",
    margin: (x: 0.85in, y: 0.85in),
    header: context [
      #set text(size: 8pt, fill: muted)
      #course
      #h(1fr)
      #semester
      #v(4pt)
      #line(length: 100%, stroke: 0.4pt + muted)
    ],
    footer: context [
      #set text(size: 8pt, fill: muted)
      #h(1fr)
      #counter(page).display()
    ],
  )

  set text(
    font: "New Computer Modern",
    size: 10.5pt,
  )

  set par(justify: true, leading: 0.65em)

  show heading.where(level: 1): it => {
    set text(size: 16pt, weight: "bold", fill: navy)
    block(above: 1.3em, below: 0.6em)[#it]
  }

  show heading.where(level: 2): it => {
    set text(size: 12pt, weight: "bold", fill: blue)
    block(above: 1em, below: 0.4em)[#it]
  }

  align(center)[
    #text(size: 21pt, weight: "bold", fill: navy)[
      #title
    ]

    #v(5pt)

    #text(size: 10pt, fill: muted)[
      #course — #semester
    ]
  ]

  v(1em)
  body
}

#let callout(title, body, color: blue) = block(
  width: 100%,
  inset: 12pt,
  radius: 4pt,
  fill: rgb("#F1F5F9"),
)[
  #text(weight: "bold", fill: color)[#title]
  #v(5pt)
  #body
]

#let definition(body) = callout(
  "Definition",
  body,
  color: blue,
)

#let theorem(body) = callout(
  "Theorem",
  body,
  color: navy,
)

#let example(body) = callout(
  "Example",
  body,
  color: rgb("#0F766E"),
)
