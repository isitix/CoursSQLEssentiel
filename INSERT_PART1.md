# Requêtes d'insertion
## CREATE 0
La société est un groupe international réparti dans plusieurs pays. Créer une nouvelle table countries  pour les pays comprennant les champs suivants :
- country_code : CHAR(3) NOT NULL clé primaire
- name : VARCHAR(32) NOT NULL
- currency_code : CHAR(3)
- currency : VARCHAR(16)

Voir le [script correspondant](./countries.sql) pour avoir la solution


Appuyez-vous sur cette table  <http://www.casi.org.uk/info/1051list/annexd.html> pour la suite des questions

## INS 1
Ajouter à la table la France
```
INSERT INTO countries (name, country_code, currency_code, currency)  VALUES ('FRANCE', 'FRA', 'FRF', 'Franc');
```

## INS 2
Ajouter à la table les Etats-Unis
```
INSERT INTO countries (name, country_code, currency_code, currency)  VALUES ('UNITED STATES', 'USA','USD','Dollar');
```


## INS 3
Ajouter à la table, en une seule requête, les pays suivants :
- Royaume-Uni
- Suisse
- Allemagne
- Pologne

```
INSERT INTO countries (name, country_code, currency_code, currency)  VALUES (
'UNITED KINGDOM',
'GBR',
'GBP',
'Pound Sterling'),
(
'GERMANY',
'DEU',
'DEM',
'Mark'),
(
'SWITZERLAND',
'CHE',
'CHF',
'Franc'),
(
 'POLAND',
'POL',
'PLZ',
'Zloty');
```

## INS 4
Ajouter à la table tous les pays dont le nom commencent par B.

Nous commençons par faire un copier-coller dans Excel de la page HTML correspondante. 

Nous faisons ensuite le ménage dans les données.

Deux solutions sont alors envisageables :
- Construire les requêtes en concaténant des chaînes de caractères dans Excel <./country_data.xls> puis copier-coller le résultat dans un fichier de script <./countries_data.sql>
- Préparer les données dans Excel <./countries_data_csv.xls> pour créer un fichier CSV <./countries_data.csv> (save as) en et le charger ensuite dans la base en mode "bulk load"

La première solution offre le plus de souplesse et s'applique bien à des volumes faibles de données. La deuxième solution sera plus performante si le volume de données à traiter est important.

Dans la deuxième solution, il est important de bien spécifier et de choisir les paramètres du CSV :
- Délimiteurs de champs
- Délimiteurs de lignes
- Encadrement ou pas des champs par des guillemets


### Chargement des données en masse
#### Modification de la configuration du serveur
Par défaut, le chargement des données en masse est désactivé pour des questions de sécurité. Pour activer le chargement, il faut préciser dans quel répertoire du serveur seront stockés les fichiers csv que l'on souhaite charger en masse. Pour savoir s'il est actif ou pas sur votre version de la base, la commande et le résultat sont :


*Actif*
```
mysql> SHOW VARIABLES LIKE "secure_file_priv";
+------------------+-------+
| Variable_name    | Value |
+------------------+-------+
| secure_file_priv | /tmp/ |
+------------------+-------+
1 row in set (0.01 sec)
```

*Inactif*
```
mysql> SHOW VARIABLES LIKE "secure_file_priv";
+------------------+-------+
| Variable_name    | Value |
+------------------+-------+
| secure_file_priv | NULL  |
+------------------+-------+
1 row in set (0.02 sec)
```
Pour activer cette option, nous ajoutons une variable dans la configuration du serveur :
```
[mysqld]
secure_file_priv="/tmp"
```
Nous avons spécifié, dans le cas présent, que les fichiers à charger doivent être placés dans le /tmp

#### Chargement des données
Pour charger les données, nous déplaçons le fichier csv vers le répertoire tmp :
```
$mv /home/mdautrey/countries_data.csv /tmp/.
```
Puis nous exécutons la commande de chargement depuis le shell mysql :
```
mysql> LOAD DATA INFILE '/tmp/countries_data.csv' INTO TABLE countries FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES (name, country_code, currency_code, currency);
```


## SEL 5
Extraire de la table la liste des pays dont le nom se termine par s
```
mysql> SELECT * FROM countries WHERE name LiKE "%s";
+--------------+----------+---------------+--------------------+
| country_code | name     | currency_code | currency           |
+--------------+----------+---------------+--------------------+
| BHS          | BAHAMAS  | BSD           | Bahamas Dollar     |
| BLR          | BELARUS  | BYB           | Belarussian Rouble |
| BRB          | BARBADOS | BBD           | Dollar             |
+--------------+----------+---------------+--------------------+
3 rows in set (0.00 sec)
```

## DEL 6
Supprimer de la table tous les pays dont le nom se termine par s
```
mysql> DELETE FROM countries WHERE name LiKE "%s";
Query OK, 3 rows affected (0.03 sec)
```


## ALT 7
Modifier la table employees :
- Ajouter un champ country_code CHAR(9) NOT NULL avec pour valeur par défaut le code des Etats-Unis 
```
mysql> SELECT country_code FROM countries WHERE name LIKE "UNITED STATES";
mysql> ALTER TABLE employees ADD COLUMN country_code CHAR(3) NOT NULL DEFAULT "USA";
```

## FK 10
Ajouter une contrainte de clé étrangère entre la table employees et la table des pays pour que tout country_code utilisé dans la table des employés soit dans la table des pays et que la suppression d'un pays entraine la suppression des employés correspondants.
```
mysql> ALTER TABLE employees ADD FOREIGN KEY (country_code) REFERENCES countries(country_code) ON DELETE CASCADE;
Query OK, 300024 rows affected (26.35 sec)
Records: 300024  Duplicates: 0  Warnings: 0
```
Sauvegarde de la base

Vérification du bon fonctionnement de la clé étrangère :
```
mysql> UPDATE employees SET country_code = "IRL" WHERE emp_no = 10009;
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`employees`.`employees`, CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`country_code`) REFERENCES `countries` (`country_code`) ON DELETE CASCADE)
```
OUF :-)

## INS 11
Insérer l'ensemble des codes pays des pays commençant par F, U et G dans la table des pays.

### Etape 1 : construction du fichier CSV
Comme lors du premier chargement

### Etape 2 : chargement des données du CSV dans la base
Comme certains codes pays sont déjà présents dans la table countries existantes et que il n'est pas possible de les supprimer sans casser la contrainte de clé étrangère, nous créons une table temporaire pour enregistrer les données du CSV.
```
mysql> CREATE TABLE tmp_countries AS SELECT * FROM countries; mysql> DELETE FROM tmp_countries; 
mysql> LOAD DATA INFILE '/tmp/full_country_data.csv' INTO TABLE tmp_countries FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 4 LINES (name, country_code, currency_code, currency);
```

### Etape 3 : Comparaison des données de la table tmp et de la table cible
```
mysql> INSERT INTO countries SELECT * FROM tmp_countries WHERE country_code NOT IN(SELECT country_code FROM countries);
```

### Etape 4 : Dump de la table
Dump de la table pour la fournir à tout le monde
```
mysqldump -u root -p employees countries > countries.sql
```

### Etape 5 Restorer la table
- Désactiver les clés étrangères
- Charger [le dump](./countries.sql)
- Réactiver les clés étrangères

```
mysql> SET FOREIGN_KEY_CHECKS=0;
mysql> \. countries.sql
mysql> SET FOREIGN_KEY_CHECKS=1;
```



