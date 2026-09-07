#import "classic-evry-report/lib.typ": (
  appendix,
  backmatter,
  chapters,
  mainmatter,
  project,
  smallprint,
)

#import "classic-evry-report/template/setup/macros.typ": *


// revision to use for add, rmv and change

// it is also possible to apply show rules to the entire project
// it is more or less a search and replace when applying it to a string.
// see https://typst.app/docs/reference/styling/#show-rules
// #show "naive": "naïve"
// #show "Dijkstra's": smallcaps

// Initialize acronyms / glossary
// See https://typst.app/universe/package/glossy for additional details.
#show: project.with(
  meta: (
    project-group: "Master 2 CNS-SR",
    participants: (
      "Paul VEROT, 20212888",
    ),
    email: (
      "pauljeanlouisverot@protonmail.com", "20212888@etud.univ-evry.fr"
    ),
    supervisors: "Damien PLOIX",
    //field-of-study: "CS",
    project-type: ""
  ),

  fr: (
    title: "étude des services ISO 27002",
    theme: "Sécurité des Systèmes d'Information",
    abstract: "",
  ),

  // clear-double-page: false,

)

= Contexte :

L’entreprise SimBuild est spécialisée dans la production de cartes SIM pour différents opérateurs téléphoniques. Elle s'est faite dérober les certificats privés de cryptage de ses cartes par une agence d’espionnage d'un grand pays. Ceci a permis à ce pays de récupérer des informations sur toutes les communications passées par des téléphones portables utilisant ces cartes SIM.

L'entreprise est structurée en deux parties. La première gère les processus transverses (finance, RH, achat, …) et la seconde la production des cartes SIM. Cette dernière activité est organisée autour de deux processus principaux : l'un relatif à la chaîne de production des cartes SIM physiques et le second visant à y inscrire les informations sensibles (numéros, certificats).

Le processus d'inscription des données sensibles se décompose en trois activités principales :
- déterminer l'opérateur cible des cartes SIM traitées, via une application hébergée en data-centre et accédée via un client léger,

- préparer les éléments de sécurité des cartes SIM, via une application installée sur les postes de travail des opérateurs et qui utilise des informations présentes sur les serveurs bureautiques de l'entreprise,

- la combinaison des deux précédentes étapes pour inscrire les informations sur les cartes SIM via l'utilisation d'un client lourd relié à la base de données de l'application et aux serveurs bureautiques.

*Exercice* :
Proposez des schémas d'attaque "kill chain" ou MITRE ATT&CK ayant permis la réalisation de l'attaque.
Expliquez si les services ISO 27002 étudiés en cours auraient permis (ou pas) de protéger l'entreprise.

= Partie 1 - Intrusion
