# Autres fonctions
## Droits des utilisateurs
Créer un utilisateur consultation dont les droits sont limités de la manière suivante :
- Accès à la table des employees
- SELECT uniquement sur la table
- Accès uniquement depuis le réseau local IMIE


### Présentation brève
Le serveur comporte une base spécifique mysql qui contient les droits des utilisateurs :
```
mysql> SHOW databases;
+--------------------+
| Database           |
+--------------------+
| articles           |
| employees          |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.00 sec)
```
La base mysql comporte les informations concernant les utilisateurs et leurs droits :
```
mysql> use mysql
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SHOW tables;
+---------------------------+
| Tables_in_mysql           |
+---------------------------+
| columns_priv              |
| component                 |
| db                        |
| default_roles             |
| engine_cost               |
| func                      |
| general_log               |
| global_grants             |
| gtid_executed             |
| help_category             |
| help_keyword              |
| help_relation             |
| help_topic                |
| innodb_index_stats        |
| innodb_table_stats        |
| password_history          |
| plugin                    |
| procs_priv                |
| proxies_priv              |
| role_edges                |
| server_cost               |
| servers                   |
| slave_master_info         |
| slave_relay_log_info      |
| slave_worker_info         |
| slow_log                  |
| tables_priv               |
| time_zone                 |
| time_zone_leap_second     |
| time_zone_name            |
| time_zone_transition      |
| time_zone_transition_type |
| user                      |
+---------------------------+
33 rows in set (0.01 sec)
```
La table user de la base mysql comporte les informations concernant les utilisateurs :
```
mysql> SELECT User, Host from user;
+------------------+-----------+
| User             | Host      |
+------------------+-----------+
| admin            | %         |
| root             | %         |
| root             | 127.0.0.1 |
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
| root             | localhost |
+------------------+-----------+
7 rows in set (0.00 sec)
```
Tous les éléments se trouvent dans la documentation de référence de mysql

### Création d'un nouvel utilisateur
```
mysql> CREATE USER 'consultation'@'172.17.2.%' IDENTIFIED BY 'consultation';
Query OK, 0 rows affected (0.08 sec)

mysql> GRANT SELECT ON employees.employees to 'consultation'@'172.17.2.%';
Query OK, 0 rows affected (0.12 sec)
```







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




