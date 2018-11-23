# Jointures externes
## JEX1
Ecrire une requête SELECT pour retourner la liste des employés qui ne sont pas associés à un pays
```
mysql> SELECT * FROM employees AS e LEFT JOIN countries AS c ON e.country_code = c.country_code WHERE c.country_code IS NULL;
```


## JEX2
Ecrire une requête SELECT pour retourner la liste des pays sans employé
```
mysql> SELECT * FROM employees AS e LEFT JOIN countriesAS c ON e.country_code = c.country_code WHERE c.country_code IS NULL;
```

