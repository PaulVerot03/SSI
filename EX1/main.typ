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

= Partie 1 - Vecteurs d'attaque envisageables

*Reconnaissance*

La distribution et le contrôle de carte SIM étant primordial pour la telecom d'un pays ou d'une région, et étant donnée l'omnipresance d'appareils cellulaire sur un terittoire donné ; la prise de contrôle de la ligne de production peut être très avantageuse à des fins lucratives ou de renseignement.

*Vecteurs plausibles*

Plusieurs vecteurs d'attaque sont envisageable :
- Phishing #sym.arrow.r un des employé avec permission sur le système s'est fait compromettre
- Vulnérabilité #sym.arrow.r une des machines sur le réseau était mal sécurisée (ex: ssh par mdp, vulnérabilité software 0day ou non mitigée ; cf. npm, )
- Inside-Job #sym.arrow.r un des employés a volontairement introduit un logiciel malicieux
- Intrusion physique #sym.arrow.r un acteur malveillant ai put avoir accès physiquement aux système (faille de sécurité sur site)
- Cheval de Troie #sym.arrow.r un appareil compromis a put être distribué ou laissé près des lieux (ex: clef USB sur le parking, disque vérolé dans la supply-chain)
\ \

== Précédents historiques par vecteur

*Phishing - Gemalto (2011)*

Le cas d'étude est similaire au piratage de l'entrprise GEMALTO en 2011. Où deux agences gouvernementales, la National Security Agency (EUA) et le Government Communications Headquarters (UK), se sont introduits dans les systèmes de l'entreprise Gemalto, fabricant des cartes SIM fournissant plus de 450 opérateurs telecoms dans le monde. Les attaquant avaient pour but de saisir les clef de chiffrements afin de pouvoir plus facillement espionner les échanges entre utilisateurs sur les réseaux cellulaires supposément.

#quote(attribution:[ Gemalto presents the findings of its investigations into the alleged hacking @noauthor_nodate_gemalto])[
  _With these stolen encryption keys, intelligence agencies can monitor mobile communications without seeking or receiving approval from telecom companies and foreign governments._]


Un rapport publié par Thalès décrit :
#quote(attribution:[ Gemalto presents the findings of its investigations into the alleged hacking @noauthor_nodate_gemalto])[
_In July 2010, a second incident was identified [...]. This involved fake emails sent to one of our mobile operator customers spoofing legitimate Gemalto email addresses. The fake emails contained an attachment that could download malicious code. We immediately informed the customer and also notified the relevant authorities both of the incident itself and the type of malware used.
During the same period, we also detected several attempts to access the PCs of Gemalto employees who had regular contact with customers._
]

La seconde partie semble indiquer que les attaquants aient eut un certain accès physique aux machines de l'entreprise. Cependant, ces machines n'étaient pas responsables des clefs de chiffrement et ne permettaient pas l'accès aux réseau sur lesquels ces machines se trouveraient. \ \

*Supply-chain - dépendances orphelines et paquets vérolés*

Dans une _supply chain attack_, un composant logiciel ou matériel est compromis avant d'arriver dans les systèmes. On peut imaginer q'une dépendance logiciel orphanée ait été employée par les attaquant, comme dans les attaques sur le _Arch Linux User Repository_ en 2026, où des paquets orphanés avait été adoptés par des acteurs malveillants afin de d'y intégrer des _info-stealer_. \ \

On peut également imaginer qu'une dépendance pour une ancienne version d'un Moteur de Base de Donnée ait été utilisée (eg. MongoDB vers.1). Ce paquet vérolé, si intégré dans un dépôt de paquet (ie. rpm-fusion, terra, cid) aurait pu être installer avec une simple mise à jour du système. \ \

*Cheval de Troie - Stuxnet*

Une autre instance autement médiatisée est le piratage (Stuxnet) par les États-Unis d'Amérique et Israel d'une centrifugeuse à matériaux radioactif en Iran. Le vecteur d'attaque étant une clef USB laissée sur le parking de l'usine. Comptant sur le fait qu'un employé la ramasse et s'en serve sur son poste de travail.@enwiki:1373234009

#quote(attribution: [Wikipedia @enwiki:1373234009])[
  _Stuxnet attacked Windows systems using an unprecedented four zero-day attacks [...]. It is initially spread using infected removable drives such as USB flash drives, which contain Windows shortcut files to initiate executable code._]

*Vulnérabilité - services exposés sur le réseau*

Le système aurait pu être visé si par exemple une interface web comme cockpit ou arrangoWebUI avait été exposé au web. Un moteur de recherche comme Shodan permet d'identifier des machines sur le web (par exemple avec les favico qui possèdent un hash unique). Une analyse avec nmap pourrait réveller des ports exposés, et ainsi donner des indices sur le type de moteur de bases de données (27017 #sym.arrow.r mongodb, 51413 #sym.arrow.r arrangodb, 5985 #sym.arrow.r couchdb). Une analyse plus poussée sur ces port permet dans certains cas d'obtenir des informations cruciales sur l'état du moteur de BDD. Par exemple, Miscrosoft SQL envéra le numéro de build avec un handshake TDS, et dans certains cas une liste complète des instances installées avec leurs port respectif. Une fois la version du logiciel connue, elle peut être cross-référencée avec des bases de données de vulnérabilité (CVE). \
Par exemple en 2017 sur PostgreSQL avec :
#quote(attribution:[CVE-2017-7546 @noauthor_nodate_cve20177546])[
  _PostgreSQL versions before 9.2.22, 9.3.18, 9.4.13, 9.5.8 and 9.6.4 are vulnerable to incorrect authentication flaw allowing remote attackers to gain access to database accounts with an empty password._]


= Partie 2 - 2 hypothèses différents
== Déroulé 1 - attaque réussie

*Reconnaissance, Weaponizing & Delivery*

On retient ici l'hypothèse phishing, cohérente avec le précédent Gemalto détaillé en Partie 1 : un employé du réseau bureautique de SimBuild est compromis via une pièce jointe piégée.

*Exploitation*

Contrairement au cas réel de Gemalto, l'application de préparation des éléments de sécurité et le client lourd relié à la base de données ne sont pas isolés du réseau bureautique compromis #sym.arrow.r l'attaquant peut donc progresser au-delà du seul réseau bureautique.

*Installation*

Pour exfiltrer des clefs sur plusieurs lots de cartes SIM, l'attaquant doit maintenir un accès dans la durée, par exemple au niveau du client lourd relié à la base de données et aux serveurs bureautiques. Le cas SUNBURST (SolarWinds, 2020) illustre une installation particulièrement furtive : le backdoor était injecté dans une DLL signée du logiciel légitime, lui permettant de survivre aux mises à jour @cisa_aa20352a. Ces DLL frauduleux avaient pu être signé grace aux clef volées.

*Command & Control*

Le canal de contrôle doit rester discret pour échapper à une éventuelle supervision réseau. SUNBURST encodait ses communications dans des requêtes DNS imitant la télémétrie légitime de SolarWinds, avec des délais volontairement irréguliers pour déjouer l'analyse comportementale @securelist_sunburst_dns.

*Action on Objective*

Cette dernière étape correspond à l'objet même du cas d'étude : l'exfiltration des certificats privés de chiffrement des cartes SIM, déjà illustrée par le cas Gemalto cité plus haut #sym.arrow.r les clefs dérobées permettent d'intercepter le trafic mobile sans coopération des opérateurs @noauthor_nodate_gemalto.

== Déroulé 2 - défense réussie

*Reconnaissance, Weaponizing & Delivery*

Le vecteur initial est identique à la Partie 2 : le phishing réussit et l'attaquant obtient un accès au réseau bureautique de SimBuild.

*Exploitation*

Dans le cas de Gemalto, les attaquants n'ont pas pu acceder aux systèmes critiques. Ce dû à leur architecture réseau :
#quote(attribution: [Gemalto presents the findings of its investigations into the alleged hacking @noauthor_nodate_gemalto])[
  _These intrusions only affected the outer parts of our networks – our office networks - which are in contact with the outside world. The SIM encryption keys and other customer data in general, are not stored on these networks. It is important to understand that our network architecture is designed like a cross between an onion and an orange; it has multiple layers and segments which help to cluster and isolate data._
]

Considérant que les systèmes de SimBuild sont segmenté de manière analogue à Gemalto, il est raisonable de penser qu'une attaque similaire aurait les mêmes effets #sym.arrow.r l'attaquant reste cantonné au réseau bureautique.

*Installation*

Sans accès aux machines portant les clefs de chiffrement, l'installation complète, conforme au plan (Reconnaissance) n'est pas possible. Cependant, il est toujours possible que les attaquants décident d'un nouvel objectif avec les machines déjà compromises (parc RH, Marketing, Administration, ...). Bien que moins sévère que les serveurs portant les clefs, une paralyze des machines peut entrainer de serieux ralentissements, et dans l'éventualité où des bases de données ou stockage de masse aient été compromis, les attaquants pourraient se rabattre sur un chiffrement des données. 

*Command & Control et Action on Objective*

N'ayant pu obtenir les clefs, ces parties ne peuvent plus se jouer.

= Partie 3 - Normes ISO 27001/2

La norme ISO/IEC 27002 est un document qui détaille les pratiques de sécurité des systèmes d'information. Publiée par ISO, l'Organisation Internationale de Standardisation, son but est de définir un standard que toutes les entreprises peuvent suivre afin d'uniformiser les notions de sécurités informatique (dans le cas de 27001/2, ISO publie d'autres document de standardisation dans tout les domaines industriels).
\ 
La norme ISO 27002 contient des recomandations quant au vecteurs d'attaque mentionnés plus haut. 

Phishing	*6.3*, *8.5* Education and training
The organization should identify, prepare and implement an appropriate training plan for technical
teams whose roles require specific skill sets and expertise. Technical teams sho


Sensibilisation, 8.5 Authentification sécurisée	Partiellement
Vulnérabilité (CVE non patché)	8.8 Gestion des vulnérabilités techniques	Oui si appliquée
Inside-Job	5.15 Contrôle d'accès, 6.4 Processus disciplinaire	Partiellement
Intrusion physique	7.x Sécurité physique	Oui
Cheval de Troie (USB)	7.10 Supports amovibles, 8.7 Protection contre malware	Oui
Supply chain (AUR/paquet vérolé)	5.19-5.22 Relations fournisseurs / ICT supply chain	Partiellement
Interface web exposée	8.20 Sécurité réseau, 8.16 Surveillance	Oui

#bibliography("bibliography.bib", title: "References")
