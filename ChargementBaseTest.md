# Chargement de la base de test
Nous travaillons sur le dump de base de test fourni par Oracle à l'addresse suivante :
<https://dev.mysql.com/doc/employee/en/sakila-structure.html>.

Pour l'installer, deux étapes sont nécessaires :
- Télécharger la repository
- Lancer le script d'installation
- Lancer le script de test de l'installation

## Téléchargement de la repository
On clone la repository git dans notre home directory :
```
$cd ~
$git clone https://github.com/datacharmer/test_db.git
```

## Lancement du script d'installation de la base
On se positionne dans la repository puis on lance le script comme suit :
```
$ cd test_db/
$ mysql -h 127.0.0.1 -u admin -p < employees.sql
```

## Test de l'installation
```
$ mysql -h 127.0.0.1 -u admin -p < test_employees_md5.sql
```


