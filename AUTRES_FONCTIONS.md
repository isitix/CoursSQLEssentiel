# Autres fonctions
## Droits des utilisateurs
Créer un utilisateur consultation dont les droits sont limités de la manière suivante :
- Accès à la table des employees
- SELECT uniquement sur la table
- Accès uniquement depuis le réseau local IMIE

## Fonctions
Une prime est versée au 1er février de chaque année aux salariés sur la base suivante :
- si le salaire est inférieur à 70000$ et l'anciennetée supérieure à 3 ans, la prime est de i2000$
- si le salaire est inférieur à 90000$ et l'ancienneté supérieure à 5 ans, la prime est de 5000$
- si le salaire est supérieur ou égal à 90000$ et l'ancienneté supérieure à 7 ans, la prime est de 10% du salaire
- sinon, la prime est de 1% du salaire

Ecrire une fonction pour appliquer cette politique salariale.

Appliquer cette fonction à l'année 1994 pour calculer le montant total des primes distribuées cette année.

## Vue
Définir une vue qui renvoie, pour chaque salarié, les informations suivantes :
- nom, prénom, date de naissance, date d'embauche
- son salaire le plus, son salaire le plus élevé

## Procédure stockée
### PS1
Définir une procédure stockée qui prend en entrée une date et renvoie en sortie les effectifs à cette date

### PS2
Définir une procédure stockée qui prend en entrée une date et renvoie la liste des employés de l'entreprise à cette date

## Trigger
Créer un journal des modifications sur la table des employees (journal_employees). Dans ce journal doivent figurer les informations suivantes :
- un timestamp donnant la date de modification
- le numéro employé
- la liste des anciennes valeurs de la table
- la liste des nouvelles valeurs de la table

Ajouter un trigger à la table des employés pour alimenter ce journal sur mise à jour des données.

Tester le journal en modifiant les données d'un employé.




