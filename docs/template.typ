#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/meander:0.4.4"
#import "@preview/lilaq:0.6.0" as lq

#let template(
  body,
  header-content: none,
  footer-content: none,
) = {
  set page(
    paper: "a4",
    margin: (
      left: 2.7cm,
      right: 2.7cm,
      top: 2.5cm,
      bottom: 2.5cm,
    ),

    header: if header-content != none {
      header-content
    },

    footer: if footer-content != none {
      footer-content
    } else {
      context align(center)[
        #set text(size: 9pt)
        #counter(page).display()
      ]
    },
  )

  set text(
    font: "Times New Roman",
    size: 11pt,
  )

  set par(
    justify: true,
    leading: 0.8em,
  )

  show heading: set text()

  set heading(numbering: "1.1.1.1")

  show heading.where(level: 1): it => {
    // pagebreak(weak: true)
    v(1em)
    it
  }

  show heading.where(level: 2): set text(weight: "bold")
  show heading.where(level: 3): set text(weight: "semibold")
  show heading.where(level: 4): set text(style: "italic")

  show figure.where(kind: image): set figure(
    // supplement: [Hình],
  )

  show figure.where(kind: table): set figure(
    // supplement: [Bảng],
  )

  set figure(numbering: "1.1")

  set table(
    stroke: .4pt,
  )

  set math.equation(
    numbering: "(1.1)",
  )

  set enum(numbering: "1.")
  set terms(separator: ":")

  set outline(indent: 1.5em)

  show: codly-init.with()

  codly(
    languages: codly-languages,
  )

  body
}
