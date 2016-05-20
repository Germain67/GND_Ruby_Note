# GND_Ruby_Note

## Installation :

- Créer un dossier et se déplacer dedans
- Taper : git clone https://github.com/Germain67/GND_Ruby_Note.git
- Se placer à la racine du projet ( cd GND_Ruby_Note )
- Editer le fichier config/database.yml et modifier la configuration de la base de données selon votre installation
- Taper : bundle install
- Taper : bundle exec rake db:drop db:create db:migrate db:seed
- Taper : bundle exec rails server
- Ouvrir un navigateur internet et se rendre sur localhost:3000/

__________

## Comptes pré-créés : 

Notation : email / password

- Compte admin : admin@admin.com / admin123
- Compte enseignant : enseignant@enseignant.com / enseignant123
- Comptes étudiants : etudiant@etudiant.com / etudiant123 -- etudiant1@etudiant.com / etudiant123 -- ... jusqu'à etudiant6
- Compte pending : pending@pending.com / pending123

__________ 

## Fonctions non implémentées :
- Gestion de la saisie de fonctions des Epreuves dans l'url
- Un formulaire pour noter les étudiants avec un seul bouton pour tout valider (actuellement en place : un bouton par élève)

__________

CLAUSS Germain - HEITZ Dylan - KARST Naïk
