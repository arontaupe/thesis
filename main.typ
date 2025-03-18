#import "@preview/versatile-apa:7.1.1": *
#show: versatile-apa.with(
title: [
#text(size: 22pt)[Human-Waste: Recycling in Social Contexts] \ 
\
A Thesis Examining the Transformative Potential for Society of Haptic, Local, and Immediate Plastic Recycling Practices and Their Cultural Implications
],
  authors: (
    (
      name: [Aron Petau \
       4044967 \
       aron\@petau.net ],
    ),
  ),
custom-affiliations: [
  #table(
  columns: 2,
  align: center,
  stroke: none,
    table.cell(colspan: 2)[\ *Affiliations*],
    [],[],
    [Universität der Künste Berlin], [Technische Universität Berlin],
    [#image("assets/images/udk_logo.png", width: 5cm)], [#image("assets/images/tu_logo.png", width: 2cm)],
)],
  // Student-specific fields
  course: [\ *Master Thesis* ],
  instructor: [
    #table(
  columns: 2,
  align: center,
  stroke: none,
    table.cell(colspan: 2)[*Instructors*],
    [],[],
    [*Maria Kyrou*], [*Prof. Albert Lang*],
    [Project InKüLe], [New Practice in Art and Technology],
    [UdK Berlin], [UdK Berlin / TU Berlin]
)
],
  due-date: datetime.today().display("[month repr:long] [year]"),

  running-head: [Human - Waste],
  author-notes: [
    //TODO
    //#include-orcid([Aron Petau], "0009-0007-6246-888X")
  ],
  keywords: (
  "waste management",
  "recycling practices",
  "object-value",
  "transformative interaction",
  "maker-education",
  "hacking",
  "archival practices",
  "collaborative recycling",
  "archival practices in design",
  "social perception of waste",
  "liminality",
  "matter"
  ),
  abstract: [#include "sections/abstract.typ"],
  font-family: "Source Serif Pro",
  font-size: 11pt,
  region: "de",
  language: "en",
  paper-size: "a4",
  implicit-introduction-heading: false,
  abstract-as-description: true,
)

#set heading(numbering: "1.")

#show outline.entry.where(
  level: 1
): set block(above: 1.3em)
#show outline.entry.where(
  level: 2
): set block(above: 1.2em)
#show outline.entry.where(
  level: 3
): set block(above: 1em)

#outline(depth: 3, indent: auto)

#pagebreak()
#include("sections/introduction.typ")
#pagebreak()
#include("sections/context.typ")
#pagebreak()
#include("sections/workshop.typ")
#pagebreak()
#include("sections/evaluation.typ")
#pagebreak()
#include("sections/discussion.typ")
#pagebreak()

#set block(above: 1em)
#bibliography(
  "bibliography/thesis.bib",
  full: false,
  title: auto,
)


#show: appendix.with(
  heading-numbering: "A",
  supplement: "Appendix",
)

#include "sections/appendix.typ"
