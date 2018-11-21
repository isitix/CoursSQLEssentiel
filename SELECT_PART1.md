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
```
mysql> SELECT e.emp_no, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date, dm.dept_no, d.dept_name, dm.from_dato_date  FROM dept_manager AS dm, employees AS e, departments AS d  WHERE dm.emp_no = e.emp_no AND dm.dept_no = d.dept_no AND dm.to_date = '9999-01-01' ORDER BY birth_date LIMIT 1;
+--------+------------+------------+-----------+--------+------------+---------+-----------+------------+------------+
| emp_no | birth_date | first_name | last_name | gender | hire_date  | dept_no | dept_name | from_date  | to_date    |
+--------+------------+------------+-----------+--------+------------+---------+-----------+------------+------------+
| 111534 | 1952-06-27 | Hilary     | Kambil    | F      | 1988-01-31 | d008    | Research  | 1991-04-08 | 9999-01-01 |
+--------+------------+------------+-----------+--------+------------+---------+-----------+------------+------------+
1 row in set (0.00 sec)
```


## SEL 15
Combien y-avait-il d'employés au 15 octobre 1988 ?
3 solutions possibles :
- toutes les personnes qui percevaient un salaire à la date considérée
- toutes les personnes qui avaient une fonction dans la société à la date considérée
- toutes les personnes qui travaillaient dans un département de l'entreprise à la date considérée.

```
mysql> SELECT COUNT(*) AS nombre_employes FROM salaries WHERE from_date <= '1988-10-15' AND to_date > '1988-10-15';
+-----------------+
| nombre_employes |
+-----------------+
|           72172 |
+-----------------+
1 row in set, 1 warning (4.24 sec)

mysql> SELECT COUNT(*) AS nombre_employes FROM titles WHERE from_date <= '1988-10-15' AND to_date > '1988-10-15';
+-----------------+
| nombre_employes |
+-----------------+
|           72172 |
+-----------------+
1 row in set, 1 warning (0.68 sec)

mysql> SELECT COUNT(*) AS nombre_employes FROM dept_emp WHERE from_date <= '1988-10-15' AND to_date > '1988-10-15';
+-----------------+
| nombre_employes |
+-----------------+
|           72172 |
+-----------------+
1 row in set, 1 warning (0.49 sec)
```

## SEL 16
Quelle était la moyenne d'âge des employés au 15 octobre 1988 ?
```
mysql> SELECT AVG(DATEDIFF('1988-10-15', birth_date))/365 FROM employees AS e, titles AS t WHERE e.emp_no = t.emp_no AND t.from_date <= '1988-10-15' AND t.to_date>'1988-10-15';
+---------------------------------------------+
| AVG(DATEDIFF('1988-10-15', birth_date))/365 |
+---------------------------------------------+
|                                 30.22882961 |
+---------------------------------------------+
1 row in set (1.70 sec)
```


## SEL 17
Quel était le salaire moyen des employés au 15 octobre 1988 ?
```
mysql> SELECT AVG(salary) FROM salaries WHERE from_date <= '1988-10-15' AND to_date > '1988-10-15';
+-------------+
| AVG(salary) |
+-------------+
|  55719.3580 |
+-------------+
1 row in set (4.31 sec)
```


## SEL 18
Quel était le salaire minimal au 15 octobre 1988 ?
```
mysql> SELECT MIN(salary) FROM salaries WHERE from_date <= '1988-10-15' AND to_date > '1988-10-15';
+-------------+
| MIN(salary) |
+-------------+
|       38888 |
+-------------+
1 row in set (4.31 sec)
```


## SEL 19
Qui avait le plus gros salaire au 15 octobre 1988 ?

Solution en n étapes : 
```
mysql> SELECT MAX(salary) FROM salaries WHERE from_date <= '1988-10-15' AND to_date > '1988-10-15';
+-------------+
| MAX(salary) |
+-------------+
|      132511 |
+-------------+
1 row in set (4.28 sec)

mysql> SELECT * FROM salaries WHERE salary = 132511;
+--------+--------+------------+------------+
| emp_no | salary | from_date  | to_date    |
+--------+--------+------------+------------+
| 109334 | 132511 | 1988-02-15 | 1989-02-14 |
+--------+--------+------------+------------+
1 row in set (3.77 sec)

mysql> SELECT * FROM employees WHERE emp_no = 109334;  
+--------+------------+------------+-----------+--------+------------+
| emp_no | birth_date | first_name | last_name | gender | hire_date  |
+--------+------------+------------+-----------+--------+------------+
| 109334 | 1955-08-02 | Tsutomu    | Alameldin | M      | 1985-02-15 |
+--------+------------+------------+-----------+--------+------------+
1 row in set (0.00 sec)

mysql> SELECT * FROM titles WHERE emp_no = 109334;  
+--------+--------------+------------+------------+
| emp_no | title        | from_date  | to_date    |
+--------+--------------+------------+------------+
| 109334 | Senior Staff | 1993-02-15 | 9999-01-01 |
| 109334 | Staff        | 1985-02-15 | 1993-02-15 |
+--------+--------------+------------+------------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM dept_emp WHERE emp_no = 109334;
+--------+---------+------------+------------+
| emp_no | dept_no | from_date  | to_date    |
+--------+---------+------------+------------+
| 109334 | d007    | 1985-02-15 | 9999-01-01 |
+--------+---------+------------+------------+
1 row in set (0.00 sec)

mysql> SELECT * FROM departments WHERE dept_no = 'd007';
+---------+-----------+
| dept_no | dept_name |
+---------+-----------+
| d007    | Sales     |
+---------+-----------+
1 row in set (0.00 sec)
```

Solution en une seule étape :
```
mysql> SELECT e.emp_no, e.birth_date, e.first_name, e.last_name, e.hire_date, s.salary, t.title, d.dept_name, '1988-10-15' AS curr_date FROM employees e, salaries s, titles t, dept_emp de, departments d WHERE e.emp_no = s.emp_no AND  e.emp_no = t.emp_no AND e.emp_no = de.emp_no AND de.dept_no = d.dept_no AND s.from_date <= '1988-10-15' AND s.to_date > '1988-10-15' AND t.from_date <= '1988-10-15' AND t.to_date > '1988-10-15' AND salary IN (SELECT MAX(salary) FROM salaries WHERE from_date <= '1988-10-15' AND to_date > '1988-10-15');
+--------+------------+------------+-----------+------------+--------+-------+-----------+------------+
| emp_no | birth_date | first_name | last_name | hire_date  | salary | title | dept_name | curr_date  |
+--------+------------+------------+-----------+------------+--------+-------+-----------+------------+
| 109334 | 1955-08-02 | Tsutomu    | Alameldin | 1985-02-15 | 132511 | Staff | Sales     | 1988-10-15 |
+--------+------------+------------+-----------+------------+--------+-------+-----------+------------+
1 row in set (11.25 sec)
```


## SEL 20 
Quel était la masse salariale au 15 octobre 1988 ?
```
mysql> SELECT SUM(salary) FROM salaries WHERE from_date <= '1988-10-15' AND to_date > '1988-10-15';
+-------------+
| SUM(salary) |
+-------------+
|  4021377507 |
+-------------+
1 row in set (4.46 sec)
```

## SEL 21
Combien y-avait-il d'employés par département le 15 octobre 1988 ?
```
mysql> SELECT d.dept_no, d.dept_name, COUNT(*) AS nombre_employes FROM dept_emp de, departments d WHERE de.dept_no = d.dept_no AND de.from_date <= '1988-10-15' AND de.to_date > '1988-10-15' GROUP BY dept_no ORDER BY dept_name;                                    +---------+--------------------+-----------------+
| dept_no | dept_name          | nombre_employes |
+---------+--------------------+-----------------+
| d009    | Customer Service   |            4240 |
| d005    | Development        |           19665 |
| d002    | Finance            |            3992 |
| d003    | Human Resources    |            4042 |
| d001    | Marketing          |            3976 |
| d004    | Production         |           16131 |
| d006    | Quality Management |            4029 |
| d008    | Research           |            4106 |
| d007    | Sales              |           11991 |
+---------+--------------------+-----------------+
9 rows in set (2.70 sec)
```

## SEL 22
Quel est l'employé dont le salaire a le plus augmenté au cours de sa carrière ?
```
mysql> SELECT A.emp_no, e.first_name, e.last_name, e.gender, e.birth_date, e.hire_date, A.salaire_min, A.salaire_max, A.salaire_max - A.salaire_min AS augmentation FROM (SELECT emp_no, MIN(salary) AS salaire_min, MAX(salary) AS salaire_max FROM salaries GROUP BY emp_no) AS A, employees AS e WHERE A.emp_no = e.emp_no ORDER BY augmentation DESC LIMIT 1;
+--------+------------+-----------+--------+------------+------------+-------------+-------------+--------------+
| emp_no | first_name | last_name | gender | birth_date | hire_date  | salaire_min | salaire_max | augmentation |
+--------+------------+-----------+--------+------------+------------+-------------+-------------+--------------+
|  43145 | Fumino     | Frijda    | F      | 1958-02-09 | 1986-05-02 |       42514 |       96389 |        53875 |
+--------+------------+-----------+--------+------------+------------+-------------+-------------+--------------+
1 row in set (6.42 sec)
```

## SEL 23
En quelle année y-a-t-il eu le plus d'embauche ?
```
mysql> SELECT COUNT(*) AS n_embauche, YEAR(hire_date) AS annee FROM employees GROUP BY annee ORDER BY n_embauche DESC LIMIT 1;
+------------+-------+
| n_embauche | annee |
+------------+-------+
|      36150 |  1986 |
+------------+-------+
1 row in set (1.14 sec)
```


## SEL 24
En quelle année y-a-t-il eu le plus de départ ?
```
mysql> SELECT YEAR(end_date) AS annee, COUNT(*) AS n_departs FROM (SELECT emp_no, MAX(to_date) AS end_date FROM titles GROUP BY emp_no HAVING end_date <> '9999-01-01') AS D GROUP BY annee ORDER BY n_departs DESC LIMIT 1;
+-------+-----------+
| annee | n_departs |
+-------+-----------+
|  2000 |      7610 |
+-------+-----------+
1 row in set (1.66 sec)
```

## SEL 25
Combien d'employés sont nés en 1957 ?
Parmi ses employés, quelle est la proportion de femmes ?

## SEL 26
Combien y-avait-il d'employés nés en 1960 dans l'entreprise au 15 février 1984 ?

## SEL 27
Quel était le salaire moyen des employés nés en 1960 le 15 février 1984 ?


