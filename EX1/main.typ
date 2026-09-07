#import "classic-evry-report/lib.typ": (
  appendix,
  backmatter,
  chapters,
  mainmatter,
  project,
  smallprint,
)

#import "classic-evry-report/template/setup/macros.typ": *
#set quote(block: true)

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
    title: "Étude des services ISO 27002",
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

== Partie une, vecteur d'attaque :
[Reconnaissance #sym.arrow.r Delivery]

La distribution et le contrôle de carte SIM étant primordial pour la telecom d'un pays ou d'une région, et étant donnée l'omnipresance d'appareils cellulaire sur un terittoire donné ; la prise de contrôle de la ligne de production peut être très avantageuse à des fins lucratives ou de renseignement.



Plusieurs vecteurs d'attaque sont envisageable :
- Phishing #sym.arrow.r un des employé avec permission sur le système s'est fait compromettre
- Vulnérabilité #sym.arrow.r une des machines sur le réseau était mal sécurisée (ex: ssh par mdp, vulnérabilité software 0day ou non mitigée ; cf. npm, )
- Inside-Job #sym.arrow.r un des employés a volontairement introduit un logiciel malicieux
- Intrusion physique #sym.arrow.r un acteur malveillant ai put avoir accès physiquement aux système (faille de sécurité sur site)
- Cheval de Troie #sym.arrow.r un appareil compromis a put être distribué ou laissé près des lieux (ex: clef USB sur le parking, disque vérolé dans la supply-chain)
\ \
Le cas d'étude est similaire au piratage de l'entrprise GEMALTO en 2011. Où plusieurs agences gouvernementales, notamment la National Security Agency (EUA) et le Government Communications Headquarters (UK), se sont introduits dans les systèmes de l'entreprise Gemalto, fabricant des cartes SIM pour plus de 450 opérateurs telecoms dans le monde. Les attaquant avaient pour but de saisir les clef de chiffrements afin de pouvoir plus facillement espionner les échanges entre utilisateurs sur les réseaux cellulaires supposément.

#quote(attribution:[ Gemalto presents the findings of its investigations into the alleged hacking @noauthor_nodate_gemalto])[
  _With these stolen encryption keys, intelligence agencies can monitor mobile communications without seeking or receiving approval from telecom companies and foreign governments._]


Un rapport publié par Thalès décrit :
#quote(attribution:[ Gemalto presents the findings of its investigations into the alleged hacking @noauthor_nodate_gemalto])[
_In July 2010, a second incident was identified [...]. This involved fake emails sent to one of our mobile operator customers spoofing legitimate Gemalto email addresses. The fake emails contained an attachment that could download malicious code. We immediately informed the customer and also notified the relevant authorities both of the incident itself and the type of malware used.
During the same period, we also detected several attempts to access the PCs of Gemalto employees who had regular contact with customers._
]
https://www.thalesgroup.com/en/news-centre/press-releases/gemalto-presents-findings-its-investigations-alleged-hacking-sim-card

La seconde partie semble indiquer que les attaquants aient eut un certain accès physique aux machines de l'entreprise. Cependant, ces machines n'étaient pas responsables des clefs de chiffrement et ne permettaient pas l'accès aux réseau sur lesquels ces machines se trouveraient. \ \

On peut également penser d'autres vecteurs d'attaque : \

Dans une _supply chain attack_, un composant logiciel ou matériel est compromis avant d'arriver dans les systèmes. On peut imaginer q'une dépendance logiciel orphanée ait été employée par les attaquant, comme dans les attaques sur le _Arch Linux User Repository_ en 2026, où des paquets orphanés avait été adoptés par des acteurs malveillants afin de d'y intégrer des _info-stealer_. \ \

Une autre instance autement médiatisée est le piratage (Stuxnet) par les États-Unis d'Amérique et Israel d'une centrifugeuse à matériaux radioactif en Iran. Le vecteur d'attaque étant une clef USB laissée sur le parking de l'usine. Comptant sur le fait qu'un employé la ramasse et s'en serve sur son poste de travail.@enwiki:1373234009

#quote(attribution: [Wikipedia @enwiki:1373234009])[
  _Stuxnet attacked Windows systems using an unprecedented four zero-day attacks [...]. It is initially spread using infected removable drives such as USB flash drives, which contain Windows shortcut files to initiate executable code._]

On peut imaginer qu'une dépendance pour une ancienne version d'un Moteur de Base de Donnée ait été utilisée (ie. MongoDB vers.1).
Ce paquet vérolé, si intégré dans un dépôt de paquet (ie. rpm-fusion, terra, cid) aurait pu être installer avec une simple mise à jour du système. \ \

Le système aurait pu être visé si par exemple une interface web comme cockpit ou arrangoWebUI avait été exposé au web. Un moteur de recherche comme Shodan permet d'identifier des machines sur le web (par exemple avec les favico qui possèdent un hash unique). Une analyse avec nmap pourrait réveller des ports exposés, et ainsi donner des indices sur le type de moteur de bases de données (27017 #sym.arrow.r mongodb, 51413 #sym.arrow.r arrangodb, 5985 #sym.arrow.r couchdb). Une analyse plus poussée sur ces port permet dans certains cas d'obtenir des informations cruciales sur l'état du moteur de BDD. Par exemple, Miscrosoft SQL envéra le numéro de build avec un handshake TDS, et dans certains cas une liste complète des instances installées avec leurs port respectif. Une fois la version du logiciel connue, elle peut être cross-référencée avec des bases de données de vulnérabilité (CVE). \
Par exemple en 2017 sur PostgreSQL avec :
#quote(attribution:[CVE-2017-7546 @noauthor_nodate_cve20177546])[
  _PostgreSQL versions before 9.2.22, 9.3.18, 9.4.13, 9.5.8 and 9.6.4 are vulnerable to incorrect authentication flaw allowing remote attackers to gain access to database accounts with an empty password._]



#bibliography("bibliography.bib", title: "References")
