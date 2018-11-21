# Requêtes d'insertion
## CREATE 0
La société est un groupe international réparti dans plusieurs pays. Créer une nouvelle table countries  pour les pays comprennant les champs suivants :
- country_code : CHAR(3) NOT NULL clé primaire
- name : VARCHAR(32) NOT NULL
- currency_code : CHAR(3)
- currency : VARCHAR(16)

Appuyez-vous sur cette table  <http://www.casi.org.uk/info/1051list/annexd.html> pour la suite des questions

## INS 1
Ajouter à la table la France

## INS 2
Ajouter à la table les Etats-Unis

## INS 3
Ajouter à la table, en une seule requête, les pays suivants :
- Royaume-Uni
- Suisse
- Allemagne
- Pologne

## INS 4
Ajouter à la table tous les pays dont le nom commencent par B.

## SEL 5
Extraire de la table la liste des pays dont le nom se termine par s

## DEL 6
Supprimer de la table tous les pays dont le nom se termine par s

## ALT 7
Modifier la table employees :
- Ajouter un champ country_code CHAR(3), not null, valeur par défaut au code des Etats-Unis 

## UPDATE 8
Valoriser le champ country_code à la valeur du code des Etats-Unis pour l'ensemble des rangs de la table employees.

## FK 10
Ajouter une contrainte de clé étrangère entre la table employees et la table des pays pour que tout country_code utilisé dans la table des employés soit dans la table des pays et que la suppression d'un pays entraine la suppression des employés correspondants.

## INS 11
Insérer l'ensemble des codes pays dans la table des pays.


