# ModuleSQLEssentiel
## Présentation
Une module d'introduction à SQL prévue pour être réalisée sur 4 jours.

## Objectifs du module
Le stagiaire doit être capable, à l'issue du cours, de concevoir une base de données relationnelles correspondant à un schéma de données métier et d'en extraire les données (lecture, ajout, mise à jour, suppression). 

## Plan du module

Les fondamentaux :
- Expliquer l'utilité du SQL
- Apprendre à exécuter des requêtes de sélection
- Apprendre à exécuter des requêtes d’insertion
- Apprendre à exécuter des requêtes de mise à jour
- Apprendre à exécuter des requêtes de suppression
- Apprendre la notion d'intégrité des données

Les compléments :
- Connaître l'architecture d'un RDBMS
- Délivrer un code SQL performant
- Concevoir une base de données prête pour la production
- Assurer la sécurité, la disponibilité  et la protection des données privées
- Assurer la sécurité des connexions au RDBMS
- Etre efficace rapidement, charger des données, analyser, transformer
- Difficultés fréquentes sur les projets bases de données et solutions possibles

## Evaluation du module
*Capacités à acquérir :*
- Traduire un dossier de conception de base de données en SQL
- Connaître la démarche pour gérer un projet SQL
- Etre en mesure d'exploiter les données d'une base SQL

*Savoir-faire technique :*
- Connaissance de l'environnement et du vocabulaire
- Connaissance du langage SQL
- Connaissance des règles de conception des données
- Connaissance des concepts d'intégrité et de transaction
- Connaissance des mécanismes d'authentification, de la gestion des droits et de la sécurité du RDBMS

*Mode d'évaluation*
- Exercices
- QCM
- Mini-projet

## Ressources externes, bibliographie, ouvrages cités dans le cours
- Livre accessible [en ligne](https://sql.sh/) concernant SQL
- Livre de référence [Database Systems: The Complete Book](https://www.amazon.fr/Database-Systems-Complete-United-States/dp/0130319953/ref=sr_1_6?ie=UTF8&qid=1542399223&sr=8-6&keywords=ullman+database)
- Une approche de l'optimisation des applications sous MySQL : [High Performance MySQL 3e](https://www.amazon.fr/High-Performance-MySQL-Baron-Schwartz/dp/1449314287/ref=sr_1_1?s=english-books&ie=UTF8&qid=1542399298&sr=1-1&keywords=mysql+performance+tuning)
- Un livre pour comprendre l'architecture et le fonctionnement de Postgresql : [Postgresql : architecture et notions avancées](https://www.d-booker.fr/programmation-et-langage/511-architecture-et-notions-avancees-2ed.html)
- Une méthode et des techniques pour écrire du code SQL prêt pour la production : [The art of SQL](https://www.amazon.fr/Art-SQL-Stephane-Faroult/dp/0596008945/ref=sr_1_1?ie=UTF8&qid=1542619014&sr=8-1&keywords=the+art+of+sql)
- Des bonnes pratiques pour écrire du code SQL : [Joe Celko's SQL for smarties](https://www.amazon.fr/Joe-Celkos-SQL-Smarties-Fifth/dp/B011DB14JK/ref=sr_1_1?s=english-books&ie=UTF8&qid=1542619097&sr=8-1&keywords=Joe+Celko%27s+SQL+for+Smarties%2C+5th+Edition)
- Optimiser le plan d'exécution des requêtes SQL : [SQL tuning](https://www.amazon.fr/SQL-Tuning-anglais-Dan-Tow/dp/0596005733/ref=sr_1_1?s=english-books&ie=UTF8&qid=1542619674&sr=1-1&keywords=sql+tuning+o%27reilly)
- [Documentation de référence Mysql](https://dev.mysql.com/doc/refman/8.0/en/)

## Environnement utilisé pour les exercices
Nous travaillons avec la version 8 du [serveur Mysql en community edition](https://dev.mysql.com/downloads/mysql/).

Le workbench peut également être intéressant pour ceux qui souhaitent un environnement graphique <https://dev.mysql.com/downloads/workbench/>.

Le client en ligne de commande est également utile <https://dev.mysql.com/downloads/shell/>.

La version doit être choisie en fonction de l'OS présent sur leur machine.

Nous travaillons à partir de l'exemple de base de données fourni par Mysql <https://dev.mysql.com/doc/employee/en/sakila-structure.html>.

## Support de cours
- Premier support de cours, [présentation générale des RDBMS](./REAMDE.md)
- Installation de [l'environnement](./InstallationDeLEnvironnement.md)
- Chargement de [la base de données](ChargementBaseTest.md)
- Premiers exercices sur [les requêtes de sélection](./SELECT_PART1.md)
- Premiers exercices sur [insertion, suppression, mise à jour, création de table](./INSERT_PART1.md)
- QCM1 <https://goo.gl/forms/Qqdnz33cFleavOdI3>
- Exemple [insertion, mise à jour, suppression](./EXEMPLES_INSERT_UPDATE_DELETE.md) vus en cours
- QCM2 <https://goo.gl/forms/fr6XmptnCJk2liVA2>


