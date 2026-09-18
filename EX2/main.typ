// ------------------------------------------------------------------
// classic-evry-report starter file
// Fill in what you need below, uncomment the rest as you go.
// Docs: https://github.com/PaulVerot03/classic-evry-report
// ------------------------------------------------------------------

#import "classic-evry-report/lib.typ": (
  appendix,
  backmatter,
  chapters,
  mainmatter,
  project,
  smallprint,
  spiral,
)
#import "classic-evry-report/template/setup/macros.typ": *

// -- Acronyms / glossary --------------------------------------------
// https://typst.app/universe/package/glossy
// #show: init-glossary.with(
//   (
//     PBL: "Problem Based Learning",
//     web: (short: "WWW", long: "World Wide Web"),
//   ),
//   term-links: true,
// )

// -- Document-wide find/replace show rules ---------------------------
// #show "naive": "naïve"
// #show "Dijkstra's": smallcaps

#show: project.with(
  meta: (
    project-group: "Master II CNS-SR",
    participants: (
      "Paul VEROT",
    ),
    email: (
      "20212888@etud.univ-evry.fr","pauljeanlouisverot@protonmail.com"
    ),
    supervisors: "Damien PLOIX",
    //field-of-study: "",
    project-type: "", 
  ),
  fr: (
    title: "Étude des services ISO 27002",
    theme: "Sécurité des Systèmes d'Information",
    abstract: "",
  ),
  // Omit `en` entirely for a French-only document, or `fr` for English-only.

  lang: "en", // "en" or "fr" -- page-numbering format etc.
  // is-draft: true,             // skip frontmatter generation
  // margins: (inside: 2.8cm, outside: 4.1cm),
  // clear-double-page: false,   // clear to next odd page on chapters
  // font: "Libertinus Serif",
)

#spiral()
#set quote(block: true)
#set heading(numbering: "1.")
#show: mainmatter.with(skip-double: false)
#outline()

= Contexte 

L'entreprise AlphaBeta, distributrice de dentifrice, emploie des VRP (Vendeurs/Représentant/Placiers) pour placer ses produits dans les grandes surfaces sur l'ensemble du territoire français. Elle souhaite mettre en place une solution de mobilité sur tablette et smartphone Android. Cette application permettra à chacun de ses vendeurs d'informer un système centralisé :
- du magasin dans lequel chaque vendeur se trouve,
- du niveau de stock présent dans les rayons.

Cette application traitera de données sensibles puisqu'elle permettra de calculer le chiffre d'affaire réalisé.

La réalisation, l'hébergement et l'exploitation de l'application est confiée à une jeune startup EvryTop créée par des étudiants de l'université d'Evry. À l'occasion de la mise en service de la nouvelle version de l'application, il s'avère que les données de production sont corrompues et qu'il est très difficile de récupérer les anciennes valeurs.
Pour corriger le problème, il a été demandé à l'ensemble des vendeurs de réaliser une nouvelle saisie de leurs données.
Exercice :
Expliquez si les services ISO 27002 étudiés en cours auraient permis (ou pas) d'empêcher la situation de se produire ou d'en limiter les effets.

== Question
Le déploiement d'une nouvelle version a corrompu les données de production, sans possibilité de restauration : les vendeurs ont dû ressaisir leurs données. L'incident touche l'intégrité et la disponibilité des données ; pas la confidentialité. Dont l'origine est les pratiques de changement, de test et de sauvegarde autour du déploiement.

La norme ISO 27002 distingue contrôles préventifs, de détection et correctifs. On peut donc diviser la question en deux :

- Quels contrôles auraient empêché la corruption des données ?
- Quels contrôles auraient limité ses effets une fois survenue ?


= ISO 27002
La norme ISO 27002 défninit plusieurs recomendations quant à l'intégrité des données et aux relation avec les entreprises tierces contractée pour ce genre de réaslisation. 

= Analyse d'un cas réel : TSB 2018

Le problême survient lorsque l'entreprise change de fournisseur de services pour cette infrastructure.  




#bibliography("ref.bib", title:"Références", full:true)
// -- Fractal chapter title pages --------------------------------------
// Call before your first heading to turn every level-1 heading (=) into
// its own title page with a growing Heighway dragon-curve motif.
// #spiral()
// #spiral(false) // explicitly off (same as not calling it)

// #outline(depth: 2)
// #note-outline()

// -- Front matter: preface, introduction (no chapter numbers) ---------
// #show: mainmatter
// #include "chapters/introduction.typ"
// = Preface
// #lorem(100)

// -- Chapters: numbered "Chapter 1" / "Chapitre 1" ---------------------
// #show: chapters
// #include "chapters/analysis.typ"
// #include "chapters/implementation.typ"

// -- Back matter: conclusion, references (chapter numbers removed) ----
// #show: backmatter
// #include "chapters/conclusion.typ"
// #glossary(title: "List of Acronyms")
// #bibliography("references.bib", title: "References")

// -- Appendices: numbered "Appendix A" / "Annexe A" --------------------
// #show: appendix
// #include "appendices/code.typ"

// `mainmatter`, `chapters`, `backmatter` and `appendix` each also take:
//   skip-double: false   -- skip to next page only, not next odd page
//   lang: "fr"            -- override the language for just this section
