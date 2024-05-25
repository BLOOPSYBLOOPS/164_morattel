# Description de l'installation du projet de location de véhicule

## Introduction
Bienvenue dans le projet de gestion de location de véhicules. Ce document vous guidera à travers les étapes nécessaires pour installer et configurer le projet sur votre machine locale

## Prérequis

**Avant de commencer, assurez-vous d'avoir les éléments suivants :**

 - Un ordinateur avec une connexion internet.
 - Un compte GitHub (si vous récupérez le projet via un lien GitHub).

## Téléchargement des fichiers du projet
**Télécharger le dossier ZIP**

1. Allez sur le lien GitHub du projet.
2. Cliquez sur le bouton "Code" puis "Download ZIP".
3. Décompressez le dossier ZIP téléchargé sur votre machine.

## Installation des logiciels requis

**Laragon**
1. Téléchargez Laragon depuis le site officiel : https://laragon.org/download/
2. Installez Laragon en suivant les instructions.
3. Ouvrez Laragon et démarrez les services Apache et MySQL.

**PyCharm**
Téléchargez PyCharm depuis le site officiel : https://www.jetbrains.com/pycharm/download/
Installez PyCharm en suivant les instructions.

## Configuration du projet

**Importation du projet dans PyCharm**
1. Ouvrez PyCharm.
2. Sélectionnez "Open" et naviguez vers le dossier du projet que vous avez décompressé.
3. Cliquez sur "OK" pour ouvrir le projet.

**Configuration de la base de données**
1. Importez le dernier dump de la base de données fourni dans le projet.
2. Ouvrez Laragon et cliquez sur "Database"
3. Créez une nouvelle base de données.
4. Importez le fichier DUMP (fichier .sql)

## Lancement du projet

1. Assurez-vous d'avoir votre base de données ouverte.
2. Dans le projet Pycharm: séléctionnez puis Run "run_mon_app.py"
3. Cliquez sur le lien Flask qui apparaît dans le terminal en bas.

## Conclusion
Vous avez désormais accès au site et pouvez gérer une société de location de véhicule

**Onglet véhicule:** Affiche les véhicules appartenant à votre société qui pourront être loué,
vous pouvez en ajoutez autant que vous vouslez et vous pouvez désigner leur plaque d'immatriculation.

**Onglet Garages:** Affiche les garages de votre société avec leur adresses et leur nombre de places totals
Vous pouvez ajouter les voitures qui sont entreposée dedans.


**Note :** Veuillez vous référer aux fichiers PDF fournis dans le dépôt GitHub pour plus de détails sur le cahier des charges, le MCD, le MLD et le dictionnaire des données.
