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

On peut isoler les éléments suivants : 

== Sauvegarde des Informations
Une simple sauvegarde des données aurais complétement annulé le problême. 

La norme ISO indique : 
#quote(attribution: [8.13 @iso27002_2022])[
  _A topic-specific policy on backup should be established to address the organization’s data retention and information security requirements.Adequate backup facilities should be provided to ensure that all essential information and software can be recovered following an incident or failure or loss of storage media_ \
  [...] \
  _c)  storing the backups in a safe and secure remote location, at a sufficient distance to escape any damage from a disaster at the main site;_
]

La norme recomande d'avoir plusieurs sauvegarde placées à des lieux différents pour éviter de toutes les perdres en cas d'évènement grave (ex. tremblement de terre, innondation, ...). \

ISO ne donne pas de recommendation pratique sur comment opérer ces systèmes de sauvegarde. Cependant, l'*ANSSI* @ANSSI dispose d'un guide qui détaille, de manière non technique, les meilleures pratiques quant aux sauvegardes. 
== Changement de Gestion

La source spécifique de l'incident provient d'une entreprise tierce qui vennait effectuer un service de migration. La norme décrit comment ces changements aux systèmes devraient etre oppérés. 
#quote(attribution: [8.32  @iso27002_2022])[
  _Introduction of new systems and major changes to existing systems should follow agreed rules and a formal process of documentation, specification, testing, quality control and managed implementation. Management responsibilities and procedures should be in place to ensure satisfactory control of all changes. \
  Change control procedures should be documented and enforced to ensure the confidentiality, integrity and availability of information in information processing facilities and information systems, for the entire system development life cycle from the early design stages through all subsequent maintenance 
efforts._
]
Ici, la norme spécifie que les changements doivent être documentés et testés.

== Ségrégation des environement de developpement et production

#quote(attribution: [8.31 @iso27002_2022])[
  _Without adequate measures and procedures, developers and testers having access to production systems can introduce significant risks (e.g. unwanted modification of files or system environment, system  failure,  running  unauthorized  and  untested  code  in  production  systems,  disclosure  of confidential data, data integrity and availability issues). There is a need to maintain a known and stable environment in which to perform meaningful testing and to prevent inappropriate developer access to 
the production environment._
]
== Relation fournisseur/client

Note : même ayant suivi des cours de droit, je ne suis pas un expert ou même qualifié en matière de législation. J'ai donc demandé à un ami avocat de m'aider sur cette partie.

L'entreprise évryenne s'expose à des actions punnitives et dédomagement. 
Conformément au code civil ; 
art.1217-C : l'entreprise AlphaBeta peux refuser ou suspendre l'execution des ses obligations (ici obligation de payment pour les services), exiger une réduction du prix ou demander la réparation des conséquences ainsi que resoudre le contrat.
\
Dans le contexte, il est probable que AlphaBeta demande une réduction du prix et suspende ses obligations le temps de restaurer les données. La startup EvryTop sera contrainte de restaurer les systèmes sans gratification. AlphaBeta a également le droit de refuser de travailler avec EvryTop, et exiger l'intervention d'une autre entreprise, à charge d'EvryTop.

art.1231-3
#quote(attribution: [art.1231-3 Code Civil])[
  _Le débiteur n'est tenu que des dommages et intérêts qui ont été prévus ou qui pouvaient être prévus lors de la conclusion du contrat, sauf lorsque l'inexécution est due à une faute lourde ou dolosive._
]
Ce qui indique que les dommages éventuels devaient être prévu de le contrat signé par EvryTop et AlphaBeta, hors faude grave ou dolosive. Il faut donc determiner dans le contexte la nature de la faute.  [detailler]


art.1170
Toute clause qui prive de sa substance l'obligation essentielle du débiteur est réputée non écrite. 

Dans le cadre de la migration de donnée, l'intégrité des données est jugée comme une obligaiton essentielle, ainsi la perte des données peut être considérée comme faute lourde (négligence).  

Pour compléter le point évoqué sur art.1217-C, 

voir l'arrêt du 22 octobre 1996 de la cours de Cassation


art.1231-5

Cependant, il est important de noter l'obligation de moyens contre l'obligation de resultats. Si AlphaBeta n'avait pas donné à EvryTop les moyens de faire des sauvegardes, alors la responsabilité et l'obligation de produire un resulta d'EvryTop est réduite.  

Également, si les bases de données contenaient des informations personnelles, la législation impose le signalement de l'incident à la CNIL, conformément à la RGPD (art.34).
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
