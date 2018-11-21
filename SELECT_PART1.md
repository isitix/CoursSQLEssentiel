# Requêtes de sélection
## SEL 0
Quels sont les champs de la base dont la valeur peut être null ?
Combien y-a-il de valeurs null pour chacun de ces champs ?

Pour répondre à cette question, consulter le schéma de la base qui se trouve à <https://github.com/datacharmer/test_db/blob/master/employees.sql>. On en déduit que seul le champ to_date de la table titles peut être null. On réalise la requête correspondante. Aucun résultat null => pas de valeur null dans la base.

```
mysql> SELECT * FROM titles WHERE to_date IS NULL;
Empty set (0.25 sec)
```

## SEL 1
Quelle est la date d'entrée du premier employé ?

```
mysql> SELECT MIN(hire_date) FROM employees;
+----------------+
| MIN(hire_date) |
+----------------+
| 1985-01-01     |
+----------------+
```

## SEL 2
Quelle est la date d'entrée du dernier employé ?

```
mysql> SELECT MAX(hire_date) FROM employees;
+----------------+
| MAX(hire_date) |
+----------------+
| 2000-01-28     |
+----------------+
1 row in set (0.16 sec)
```

## SEL 3
Combien de femmes sont passées par la société ?
```
mysql> SELECT COUNT(*) AS n_femmes FROM employees WHERE gender='F';
+----------+
| n_femmes |
+----------+
|   120051 |
+----------+
1 row in set (0.14 sec)
```


## SEL 4
Combien y-a-t-il de départements dans la société ?
```
mysql> SELECT COUNT(*) FROM departments;
+----------+
| COUNT(*) |
+----------+
|        9 |
+----------+
1 row in set (0.01 sec)
```



## SEL 5
Combien y-a-t-il de titres différents dans la société ?
```
mysql> SELECT COUNT(DISTINCT title) FROM titles;
+-----------------------+
| COUNT(DISTINCT title) |
+-----------------------+
|                     7 |
+-----------------------+
1 row in set (0.30 sec)
```


## SEL 6
Combien y-a-t-il d'employés embauchés entre 1985 et 1990 ?
```
mysql> SELECT COUNT(*) AS n_employes FROM employees WHERE YEAR(hire_date) BETWEEN 1985 AND 1990;
+------------+
| n_employes |
+------------+
|     190407 |
+------------+
1 row in set (0.15 sec)
```


## SEL 7
Combien y-a-t-il d'employés embauchés en 1995, 1997 ou 1999 ?
```
mysql> SELECT YEAR(hire_date), COUNT(*) AS n_employes FROM employees WHERE YEAR(hire_date) IN (1995, 1997, 1999) GROUP BY YEAR(hire_date);
+-----------------+------------+
| YEAR(hire_date) | n_employes |
+-----------------+------------+
|            1995 |      12115 |
|            1999 |       1514 |
|            1997 |       6669 |
+-----------------+------------+
3 rows in set (0.14 sec)
```


## SEL 8
Quel est le dernier employé dans la liste alphabétique nom-prénom ?
```
mysql> SELECT last_name, first_name FROM employees ORDER BY last_name DESC, first_name DESC LIMIT 1;
+-----------+------------+
| last_name | first_name |
+-----------+------------+
| Zykh      | Zhongwei   |
+-----------+------------+
1 row in set (0.21 sec)
```


## SEL 9
Quel était le salaire moyen des employés au 1er janvier 1998 ?
```
mysql> SELECT AVG(salary) FROM salaries WHERE from_date <= '1998-01-01' AND to_date > '1998-01-01';
+-------------+
| AVG(salary) |
+-------------+
|  64604.5112 |
+-------------+
1 row in set (0.85 sec)
```


## SEL 10
Combien y-a-t-il de titres différents dans la société ?

Voir question 5

## SEL 11
Combien y avait-il d'employés "Technique Leader" au 1er janvier 1999 ?
```
mysql> SELECT COUNT(*) AS n_leaders FROM titles WHERE title = 'Technique Leader' AND from_date <= '1999-01-01' AND to_date > '1999-01-01';
+-----------+
| n_leaders |
+-----------+
|     12286 |
+-----------+
1 row in set (0.25 sec)
```

## SEL 12
Combien y-a-il de valeurs null dans la table titles champ to_date ?

Voir question 0

## SEL 13
Qui est le dept_manager le plus ancien ?
```
mysql> SELECT e.emp_no, e.first_name, e.last_name FROM titles AS t, employees AS e WHERE e.emp_no=t.emp_no AND  t.to_date='9999-01-01' ORDER BY from_date LIMIT 1;
+--------+------------+-----------+
| emp_no | first_name | last_name |
+--------+------------+-----------+
| 235233 | Jayesh     | Minakawa  |
+--------+------------+-----------+
1 row in set (0.38 sec)
```

## SEL 14
Quel département le département manager le plus ancien manage-t-il ?

## SEL 15
Combien y-avait-il d'employés au 15 octobre 1988 ?

## SEL 16
Quelle était la moyenne d'âge des employés au 15 octobre 1988 ?

## SEL 17
Quel était le salaire moyen des employés au 15 octobre 1988 ?

## SEL 18
Quel était le salaire maximal au 15 octobre 1988 ?

## SEL 19
Qui avait le plus gros salaire au 15 octobre 1988 ?

## SEL 20 
Quel était la masse salariale au 15 octobre 1988 ?

## SEL 21
Combien y-avait-il en moyenne d'employés par département le 15 octobre 1988 ?

## SEL 22
Quel est l'employé dont le salaire a le plus augmenté au cours de sa carrière ?

## SEL 23
En quelle année y-a-t-il eu le plus d'embauche ?

## SEL 24
En quelle année y-a-t-il eu le plus de départ ?

## SEL 25
Combien d'employés sont nés en 1957 ?
Parmi ses employés, quelle est la proportion de femmes ?

## SEL 26
Combien y-avait-il d'employés nés en 1960 dans l'entreprise au 15 février 1984 ?

## SEL 27
Quel était le salaire moyen des employés nés en 1960 le 15 février 1984 ?


