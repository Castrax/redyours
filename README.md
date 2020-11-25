# DOCUMENTATION REDYOURS

## Versions

Ruby : 2.7.0

RoR : 6.0.3.4

Host : Heroku

Lien : [redyours.xyz](http://www.redyours.xyz)

## BDD

J'ai choisi d'implémenter une base de données PostgreSQL, car elle est une base de données OpenSource maniable, et scalable.
postgres : 13.0

## Modélisation de BDD

![Modélisation BDD](https://zupimages.net/up/20/48/crwh.png)

La BDD contient 3 tables : 
* une table __users__ qui contient les champs obligatoires et une colonne Admin (voir le paragraphe sur Sidekiq ci-dessous)
* une table __tickets__ qui contient tous les champs obligatoires des tickets, un booléen open (qui stocke l'ouverture ou non du ticket), une colonne status qui stocke le statut des tickets en fonction de leur avancement, une colonne photo_url qui stocke l'url des visuels liés aux tickets, et la clé étrangère :user_id qui correspond à la table users. 
* Enfin, une table de jointure __comments__ qui contient les deux clés étrangères correspondant à la table users, et à la table tickets.

## Hypothèses et choix techniques

### Utilisateurs
J'ai supposé qu'un gestionnaire de ticket pour un ticket donné, était le user affecté au ticket à sa création (de façon aléatoire par un script automatique).

### Système d'authentification
J'ai implémenté le système d'authentification le plus utilisé pour le framework Ruby on Rails, à savoir la gem Devise (voir le paragraphe sur les gems ci-dessous). N'importe quel utilisateur peut s'authentifier, se créer un compte depuis la navbar à n'importe quel endroit du site.
J'ai délibérement choisi de ne pas implémenter de solution d'authorization, comme il n'était pas précisé qu'il fallait développer un CRUD pour les models de Ticket, ou de Comment.

### Système de tickets
Affichage des tickets ouverts sur 3 colonnes en fonction de leur statut, avec implémentation d'un système de modals pour afficher les shows des tickets.
Pour ce faire, et pour ne pas perturber l'UX, j'ai développé le create des comments en ajax.
Possibilité de fermer un ticket par son gestionnaire (update du ticket).
L'attribution d'un ticket se fait grâce à la méthode de classe User.pick_a_user disponible dans le model User.

### Création de tickets
La création de tickets se fait via l'exécution d'un job Active Job en arrière-plan (classe TicketsJob) qui tourne désormais en production, grâce à Sidekiq et Redis. En fonction de l'heure de la journée, une méthode create_ticket (qui permet la création d'un ticket en base de données), ou une méthode raise_error (qui affiche des strings) est appelée.
Le scheduler cron de Sidekiq cron permet de lancer le job toutes les 5 minutes.
Une autre solution aurait été d'ajouter la gem Whenever pour gérer la partie scheduler, afin de gérer le planning d'heures en dehors du job.

### Gestion des envois d'email
Deux emails sont envoyés en instantané (deliver_now) par la plateforme :
* L'un a la création d'un ticket au gestionnaire de ticket 
* L'autre envoyé au gestionnaire de ticket lors de la publication d'un comment par un autre utilisateur que le gestionnaire
J'ai utilisé ActionMailer pour paramétrer les emails, et en production, j'utilise le service Mailgun pour l'envoi des mails.

### Gems non présentes nativement
*Devise*
La gem évite d'implémenter à la main tout le système d'authentification, et notamment les vues pour se connecter au site.
C'est la gem la plus utilisée pour l'authentification.

*Cloudinary*
Cloudinary est un service tiers de stockage cloud de photos et de fichiers. Elle m'a été utile pour héberger les petites images des tickets. Cette gem est nécessaire lorsque l'on déploie sur Heroku, car leur système de dynos étant éphémère, on ne peut pas y stocker des images. 

*Faker*
Faker est une gem permettant de générer des fausses données. Elle m'a été utile pour générer des fake titres et descriptions pour les tickets.

*Sidekiq, Sidekiq-failures et Sidekiq-cron*
Ce sont des gems permettant de faire tourner des background jobs sur Rails. Elle m'ont été utiles pour faire tourner le job nécessaire à la création des tickets, pour le planifier, et pour vérifier les erreurs via le Dashboard Sidekiq (disponible sur l'url /sidekiq), ouvert à tous les utilisateurs étant admin.
