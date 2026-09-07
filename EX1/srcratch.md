# Contexte :

L’entreprise SimBuild est spécialisée dans la production de cartes SIM pour différents opérateurs téléphoniques. Elle s'est faite dérober les certificats privés de cryptage de ses cartes par une agence d’espionnage d'un grand pays. Ceci a permis à ce pays de récupérer des informations sur toutes les communications passées par des téléphones portables utilisant ces cartes SIM.

L'entreprise est structurée en deux parties. La première gère les processus transverses (finance, RH, achat, …) et la seconde la production des cartes SIM. Cette dernière activité est organisée autour de deux processus principaux : l'un relatif à la chaîne de production des cartes SIM physiques et le second visant à y inscrire les informations sensibles (numéros, certificats).

Le processus d'inscription des données sensibles se décompose en trois activités principales :
- déterminer l'opérateur cible des cartes SIM traitées, via une application hébergée en data-centre et accédée via un client léger,
- préparer les éléments de sécurité des cartes SIM, via une application installée sur les postes de travail des opérateurs et qui utilise des informations présentes sur les serveurs bureautiques de l'entreprise,
- la combinaison des deux précédentes étapes pour inscrire les informations sur les cartes SIM via l'utilisation d'un client lourd relié à la base de données de l'application et aux serveurs bureautiques.


Proposez des schémas d'attaque "kill chain" ou MITRE ATT&CK ayant permis la réalisation de l'attaque.
Expliquez si les services ISO 27002 étudiés en cours auraient permis (ou pas) de protéger l'entreprise.


# Schema d'attaque

**kil-chain**
Reconnaissance -> Weaponizing -> Delivery -> Exploitation -> Installation -> Command & Control -> Action Objective

Partie une, mode d'attaque : 

Plusieurs vecteurs d'attaque sont envisageable : 
- Phishing -> un des employé avec permission sur le système s'est fait compromettre 
- Vulnérabilité -> une des machines sur le réseau était mal sécurisée (ex: ssh par mdp, vulnérabilité software 0day ou non mitigée ; cf. npm, )
- Inside-Job -> un des employés a volontairement introduit un logiciel malicieux
- Intrusion physique -> un acteur malveillant ai put avoir accès physiquement aux système (faille de sécurité sur site)
- Cheval de Troie -> un appareil compromis a put être distribué ou laissé près des lieux (ex: clef USB sur le parking, disque vérolé dans la supply-chain)

Dans ce cas d'étude, l'attaque semble similaire à l'attaque sur Solarwinds en 2020 :

Le rapport de #blue[CISA] indique que plusieurs paquets contenant des malware ont été signé avec des clefs volées, des messages et des fichiers critiques ont également été déchiffreé avec ces clefs. #quote(attribution:[CISA @cisa])[
  _During the SolarWinds Compromise, APT29 was able to get SUNBURST signed by SolarWinds code signing certificates by injecting the malware into the SolarWinds Orion software lifecycle. \ \ During the SolarWinds Compromise, APT29 obtained PKI keys, certificate files, and the private encryption key from an Active Directory Federation Services (AD FS) container to decrypt corresponding SAML signing certificates_
]

Le cas d'étude étant fictif, je partirait du principe que l'attaque s'est déroulé dans un mode similaire.

Dans une _supply chain attack_, un composant logiciel ou matériel est compromis avant d'arriver dans les systèmes. On peut imaginer q'une dépendance logiciel orphanée ait été employée par les attaquant, comme dans les attaques sur le **Arch Linux User Repository** en 2026, ou des paquets orphanés avait été adopté par des acteurs malveillant afin de d'y integrer des _info-stealer_.

Pour les besoins de l'exercices, on imaginera qu'une dépendance pour une ancienne version d'un Moteur de Base de Donnée ait été utilisée (ie. MongoDB vers.1).
Ce paquet vérolé, si intégré dans un dépôt de paquet (ie. rpm-fusion, terra, cid) aurait pu être installer avec une simple mise à jour du système.

Le système aurait pu être visé si par exemple une interface web comme cockpit ou arrangoWebUI avait été exposé au web. Un moteur de recherche comme Shodan permet d'identifier des machines sur le web (par exemple avec les favico qui possèdent un hash unique). Une analyse avec nmap pourrait réveller des ports exposés, et ainsi donner des indices sur le type de moteur de bases de données. Une analyse plus poussée sur les
