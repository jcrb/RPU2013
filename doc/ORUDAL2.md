ORUDAL
========================================================
author: Dr JC Bartier
date: 3/12/2013
transition: rotate

RPU (1)
========================================================

Les eléments du RPU sont des données médico-administratives standards qui doivent figurer dans un dossier médical de base. 

Relever un RPU ne nécessite donc **pas un travail supplémentaire** de la part du personnel médical ou para médical.

Un certain nombre de ces informations sont **disponibles dès l'admission du malade** et avant toute intervention médicale.

RPU (2)
=========================================================

La transmission de ces informations au fil de l'eau permet de disposer en temps (quasi) réel, d'éléments qui entrent en ligne de compte pour l'élaboration d'**indicateurs de tension** (core).

C'est donc plus un problème de **SI** qu'un problème médical.

RPU (3)
========================================================

Un **RPU** est composé de **18 items** qui peuvent être
divisés en deux groupes.

- groupe principal (**core**)

  éléments de base qui peuvent **toujours** être relevés de manière exhausive dès l'admission du patient et transmis au fil de l'eau au concentrateur régional.

  C'est le minimun qui doit pouvoir être transmis au moins une fois par 24 heures.

- groupe complémentaire (**supplementary**)

Partie Core (12)
========================================================


- FINESS géographique de l'établissement
- date/heure d'entrée 
- code postal du lieu de résidence
- commune
- date de naissance
- sexe

***

- mode d'entrée
- provenance
- mode de transport
- mode de prise en charge
- CCMU
- motif de recours

Partie supplémentaire (6)
=========================================================

- date/heure de sortie
- Diagnostic principal
- diagnostics associés
- gestes selon CCAM
- mode de sortie
- l'orientation

<small>Le recueil plus tardif, nécessite une compétence médicale (diagnostic principal) et un délai qui peut dépasser 24 heures (date de sortie). </small>

Le service dispose de **6 jours** pour compléter cette partie.

Difficultés - imprécisions
========================================================
type: section

FINESS
========================================================

Il existe deux FINESS
- *juridique* qui est le même pour toutes les stuctures appartenant à  la même entité et 
- *géographique* qui est spécifique d'un site. 

Le FINESS juridique ne permet pas de distinguer l'activité d'un site particulier. 

Il est donc recommandé d'utiliser systématiqement le **FINESS géographique**. 

Le n° FINESS doit comporter **9 chiffres**.

Date et heure (1)
========================================================
 
 **Heure d'entrée** est à priori simple à définir: c'est l'heure  laquellele patient est enregistré. Dans la plupart des cas elle coincide avec l'arrivée physiqe du consultant, mais pas toujours (parsonnes annoncées par le SAMU, transfert du dossier SMUR).

Date et heure (2)
========================================================

 **Heure de sortie** est floue et ne fait pas consenssus. 
 
 Il peut s'agir de l'heure de la décision de sortie (prescription médicale horodatée et signée) ou de l'heure de sortie physique du SU, par symétrie avec l'heure d'entréee. L'heure de sortie est claire pour un patient ambulant et valide. 
 
 Pour un **transfert** dans un service ou **retour** par ambulance, se pose le problème du délai et du lieu d'attente (couloir) de l'attente du moyen de transport (ambulance, brancardiers). 
 
 L'**hospitalisation en UHTCD** est une sortie du point de vue du RPU mais une simple translation pour le service (porosité accueil/UHCD).
 
 Date et heure (3)
========================================================

Règles de rejet des durées de passage (non consensuelles)
- nulle ou négatives
- inférieures à 10 mn
- supérieures à 72 heures
 
Code postal
========================================================

- Code à 5 chiffre valable uniquement pour les personnes résidentes sur le territoire français. 
- La norme RPU définit un code de résidence pour les non résidents. Ce code (**99 999**)n'est en général pas respecté et nécessite un détrompage reposant sur le pays de résidence (pas demandé dans le RPU). 
- Pour des régions frontalières comme l'Alsace ilpourrait être intéressant de distinguer les résidents Suisses et Allemands des autres non résidents.
- Pour la partie des RPU à transmettre à l'**ATIH** ce dode doit être remplacé par un **code de résidence** calqué sur le modèle du **PMSI**.


Commune
========================================================

- Le nom de la commune figure en clair, ce qui peut poser des problèmes de cohérence (noms composés, accents). 

- Il est recommandé d'utiliser la **nomenclature des viles de l'INSEE**. 

- Pour le **schéma ATIH** le nom de la commune est remplacé par son code INSEE.


Date de naissance
========================================================

Pour le **schéma ATIH** la date de naissance est remplacée par l'**âge** calendaire à la date d'entrée du patient.

Sexe
========================================================

Le RPU attent une réponse dichotomique, **H**omme ou **F**emme (pas masculin / féminin)

Mode d'entrée
========================================================

Provenance
========================================================

Mode de transport
========================================================

Mode de prise en charge
========================================================

CCMU
========================================================

la CCMU 
doit être déterminée **dès l'admission** et non  la sortie du patient, ou être modifiée parceque l'état du patient évolue pendant le séjour aux urgences (étude INVS).

Motif de recours
========================================================

- La règle est d'utiliser le **thésaurus SFMU** version 2013, basé sue la classification internationale des maladies (CIM 10), seul reconnu par l'INVS et imposé parle ministère de la santé. 

- **La liste compte encore une quinzaine d'items inexacts ou imprécis.**

- la FEDORU va saisir officiellement la SFMU pour quelle corrige la page **RECOURS**

Diagnostic principal
========================================================

- Il se code avec la **CIM10** telle qu'elle est définie par l'OMS dans sa version officielle. 
- Ce code CIM10 habituellement utilisé dans les hôpitaux est celui du **PMSI**. Ce code comporte une racine commune avec le code CIM10 officiel. 
- Il n'y a donc pas lieu de disposer d'un thésaurus particulier et le **code PMSI est parfaitement utilisable** (pas de redondance, granularité plus fine)

Diagnostics associés
========================================================

- Même remarque de pour le diagnostic principal. 
- La porosité entre le SU et l'UHTCD rend cet item très imprécis. 
- Il est l'objet de discussions animées.

Gestes selon CCAM
========================================================

Mode de sortie
========================================================

L'orientation
========================================================

Les données
===========

conformité, l’exhaustivité, la qualité et la cohérence

Nécessité de définir la conformité d’un RPU, les règles d’acceptation d’un RPU
• En d’autres termes, quels sont les RPU à rejeter? Quel est le contenu minimal
•
•
•
•
•
attendu?
En premier lieu, il s’agit du contenant à savoir de la conformité structurelle du RPU
(format XML avec balises ad hoc)

En second lieu, il s’agit du contenu. Par exemple, faut - il rejeter un RPU en cas de
codes CIM 10 non conformes, (en sachant que les thésaurus sont, à ce jour, non
homogènes) en cas de champs vides (heure de sortie par exemple), de durées de
passage négatives ou supérieures à 72h ou encore d’incohérences entre champs ?

Dans l’hypothèse du rejet d’un RPU, quel est son devenir ? Stockage et information
du producteur ou règles d’auto complétude (utilisation de l’heure médiane pour
compléter l’absence d’une heure de sortie...) ou plus simplement d’auto correction
(correction d’un diagnostic CIM...). Concernant ces éventuelles règles de
correction, elles doivent idéalement être activées en amont de la réception c’est-
c’est -à -
dire lors de la saisie initiale
Toujours dans l’hypothèse d’un rejet de RPU, les RPU en erreur « historisés »
doivent--ils entrer en compte dans l'analyse des données et si oui, dans quelles
doivent
conditions ?
Enfin, se pose également la définition des critères d’unicité d’un RPU, le couple RPU /
FINESS géographique ne semblant pas toujours suffisant (exemple classique du
défaut d’ « étanchéité SU-
SU -UHTCD »

Les difficultés liées aux données
==========================================================
Exhaustivité des données
------------------------
L’exhaustivité concerne à la fois les données mais aussi les passages devant générer des RPU
Par exemple, certains passages pédiatriques médicaux ne sont actuellement
pas pris en compte (problème des admissions bi sites sur un même
établissement)
Autre question, que faire des passages pour urgences gynéco -
obstétricales ? (si intégration, probablement à définir)
En ce qui concerne l’exhaustivité des données, nécessité de déterminer des
champs bloquants communs mais également de définir les seuils autorisant
l’analyse
De plus un champ peut être complété mais d’une façon non exhaustive
(diagnostics associés, actes CCAM...)
Par ailleurs, intérêt de l’analyse mais aussi du suivi des courbes
d’exhaustivité. En effet, une analyse régionale permet de discuter la
pertinence de certains champs du RPU et le suivi par établissement
participe à la motivation des établissementsLes difficultés liées aux données

Les difficultés liées aux données
Exhaustivité des données
exemple d’un radar d’exhaustivité Orulor

Les difficultés liées aux données
=================================
Qualité des données
-------------------
• Les défauts de qualité peuvent relever de problèmes techniques ou de
problèmes de codage
• Exemples d’origine technique:
- zone de saisie en texte libre,
- absence de « détrompage » ou de règle sur la saisie des codes communes
(code pays étrangers...)
- durée de passage avec clôture de dossier retardée ou absence
d’étanchéité SU-
SU -UHTCD (quelles sont les bornes utilisées par le progiciel?)
- absence de transcodage (traitement et codification CCAM, orientation et
caractérisation en MCO, SSR...) ou transcodage non pertinent
- absence de champs bloquants
• Exemples de problèmes de codage:
- CCMU (cotation de la consultation d’urgence en consultation spécialisée
transformant une CCMU1 en 2, séparation 3/4/5 subjective)
- codage du diagnostic principal trop imprécis (asthénie
(asthénie--AEG, malaise
malaise--
syncope--lipothymie, autres recours....). Possibilité d’intégrer une fonction de
syncope
diagnostic lié
- absence de cotation ou cotation partielle des diagnostics associés, des
actes CCAM

Les difficultés liées aux données
=================================
Cohérences des données
-----------------------
• Nécessité de définir des règles de cohérence entre les différents champs
Exemples
Provenance - mode d’entée
CCMU et orientation (CCMU 5 et RAD)
Sexe et /ou âge et diagnostic
Mode de sortie et mode d’orientation (retour à domicile et
hospitalisation en UHTCD sur les progiciels non étanches)
Ce contrôle de cohérence devrait idéalement s’effectuer lors de la
saisie initiale sur le progiciel dédié car le post traitement est difficile
et aléatoire
Attention également aux faux « non renseigné » en particulier pour
les calculs d’exhaustivité

Les difficultés liées aux bornes et aux définitions
===================================================
• Nécessité d’utiliser les mêmes bornes et les mêmes définitions:
- Pour les âges et les classes d’âge
- Pour les jours (0h01 à 23h59 ou 08h
08h-- 08h..), les semaines, les WE ,
les périodes PDSES et PDSA
• Comment traiter les groupes 4?
• Définition du TOP, du taux de recours aux urgences
• Modalités de prise en compte des « sorties atypiques » (fugue,
contre avis médical, parti sans attendre) et des réorientations
• Prise en compte ou non du parcours de soins intra SU du patient
(temps d’attente de prise en charge, temps de prise en charge
médicale (avec localisation), temps d’attente de sortie)

Difficultés liées aux axes d’analyse
=====================================
• Il s’agit essentiellement de difficultés d’interprétation
• Exemple de la durée moyenne de passage (DMP): comment
comparer la DMS (ou la médiane) de deux SU. La
comparaison brute n’a pas de sens de même que les objectifs
non pondérés de type : 80% des passages de moins de 4h.
Cette DMP est impactée par de multiples paramètres souvent
totalement indépendants de la « pertinence » du SU
- un SU ne recevant qu’une patientèle adulte ou pire qu’une
patientèle adulte médicale ne pourra jamais atteindre
l’objectif de 80% des passages de moins de 4h (en
Lorraine, la DMP d’un enfant est de 2h versus 5 h pour un
patient de plus de 75ans)
- autre facteur à fort impact, les % des différentes CCMU ( la
réalisation d’un examen complémentaire majore de 1h la
DMP)
- enfin, quid des groupes 4 ?
Pour ce paramètre a priori simple, une comparaison d’activité
suppose l’utilisation de « coefficients de pondération »

Après la DMP, autre exemple, à savoir l’analyse de l’activité par diagnostic
Tout d’abord, il s’agit de diagnostics de présomption souvent soit
exagérément précis ou plus habituellement trop vagues (malaise -
syncope-- lipothymie, AEG ...)
syncope
Par ailleurs, dans un même champ, peut figurer un diagnostic, un
motif de recours ou une circonstance
Enfin, il existe une grande dispersion des diagnostics rendant
l’analyse difficile
Intérêt d’une CIM 10 « très » réduite (nouvelle version SFMU) mais
aussi d’une règle unique de regroupement des diagnostics
(forcément partiale compte tenu de la faible exhaustivité des
diagnostics associés et de l’absence habituelle de fonction de
diagnostic lié)

Dernier exemple, celui de l’interprétation des sorties dites
« atypiques » regroupant les fugues, les sorties contre avis
médical et les « partis sans attendre »
Il est tentant de considérer ce paramètre comme un
indicateur de qualité mais:
- certains progiciels n’intègrent pas les PSA
- il peut parfois s’agir d’un biais permettant de clôturer un
dossier non exhaustif (champ de saisie détourné de son usage
attendu)
C’est ainsi qu’un % important de patients partis sans attendre
peut simplement être lié à une anomalie de saisie, reflétant
un défaut de rigueur de saisie en non pas un défaut de prise
en charge de patients

Propositions d’action
================================================================

Améliorer la production, la qualité et l’exhaustivité des données
Harmoniser les modalités de collecte
Définir les règles d’acceptation d’un RPU
Déterminer un socle minimum commun de données
Préciser les définitions des termes usités
Retenir des bornes communes
Définir un socle minimum commun d’axe d’analyse
Ces axes doivent permettre la description de l’activité, la comparaison inter SU mais
aussi interrégionale, la définition d’une activité normale et anormale (en terme de
volumétrie avec son corollaire HET mais aussi en terme de services attendus)
Préciser les règles d’interprétation mais surtout les biais potentiels
Proposer des évolutions ( champs du RPU, RPU SMUR, regroupement de
pathologies, RPU et HET...)
Au total, intérêt de mettre en place une « charte qualité inter ORU »

