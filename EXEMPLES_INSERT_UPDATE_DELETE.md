# Exemples
## CASE
```
mysql> SELECT emp_no, birth_date, last_name, first_name, (CASE WHEN YEAR(birth_date) < 1965 THEN 'very old' ELSE 'young' END) AS category FROM employees LIMIT 10;
+--------+------------+-----------+------------+----------+
| emp_no | birth_date | last_name | first_name | category |
+--------+------------+-----------+------------+----------+
|  10001 | 1953-09-02 | Facello   | Georgi     | very old |
|  10002 | 1964-06-02 | Simmel    | Bezalel    | very old |
|  10003 | 1959-12-03 | Bamford   | Parto      | very old |
|  10004 | 1954-05-01 | Koblick   | Chirstian  | very old |
|  10005 | 1955-01-21 | Maliniak  | Kyoichi    | very old |
|  10006 | 1953-04-20 | Preusig   | Anneke     | very old |
|  10007 | 1957-05-23 | Zielinski | Tzvetan    | very old |
|  10008 | 1958-02-19 | Kalloufi  | Saniya     | very old |
|  10009 | 1952-04-19 | Peac      | Sumant     | very old |
|  10010 | 1963-06-01 | Piveteau  | Duangkaew  | very old |
+--------+------------+-----------+------------+----------+
10 rows in set (0.00 sec)
```

## OR

```
mysql> SELECT * FROM employees WHERE gender = 'F' OR YEAR(birth_date)> 1970 ORDER BY birth_date LIMIT 20;
```

## UNION
```
mysql> (SELECT YEAR(from_date) AS annee, MAX(salary) as salary, 'MAX' AS type FROM salaries GROUP BY annee) UNION (SELECT YEAR(from_date) AS annee, MIN(salary) as salary, 'MIN' AS type FROM salaries GROUP BY annee) ;
```

## INSERT
```
mysql> INSERT INTO departments VALUES('d010', 'Logistic');
Query OK, 1 row affected (0.06 sec)
mysql> INSERT INTO departments VALUES ('d011', 'International'), ('d012', 'Innovation');
Query OK, 2 rows affected (0.11 sec)
Records: 2  Duplicates: 0  Warnings: 0
```

## UPDATE
```
mysql> UPDATE departments SET dept_name = 'Recherche' WHERE dept_no = 'd008';
```

## Copie d'une table pour sauvegarde
```
mysql> CREATE TABLE departments_old AS SELECT * FROM departments;
```

## Mise à jour d'une table à partir d'une table de sauvegarde
```
mysql> UPDATE departments AS d, departments_old AS do SET d.dept_name = do.dept_name WHERE d.dept_no = do.dept_no;
```







