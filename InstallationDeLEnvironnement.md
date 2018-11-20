# Installation de l'environnement
## Options possibles
Plusieurs options s'offrent à vous pour l'environnement de développement :
- Installation directe de Mysql et des outils sur votre poste de travail
- Lancement d'un container Mysql dans Docker
- Utilisation d'un service cloud (AWS, OVH, Google Cloud Compute, Azure...)

## Configuration choisie
Nous sommes partis sur une solution mixte :
- Installation du workbench et d'un client shell sur la machine locale
- Démarrage du serveur dans docker

En situation normale, nous n'aurions probablement pas déployé le workbench mais uniquement une machine docker avec le serveur et le shell correspondant. Cette configuration est en effet la plus simple à gérer à tous points de vue.

Comme il s'agit d'une formation et que certains stagiaires peuvent vouloir utiliser le workbench, nous avons décidé de l'installer en local.

## Méthode d'installation du workbench
### Etat des lieux des paquets installés
On vérifie la liste des paquets déjà installés : 
```
$sudo dpkg -l | grep mysql
ii  akonadi-backend-mysql                   1.13.0-2+deb8u2                            all          MySQL storage backend for Akonadi
ii  libmysqlclient18:amd64                  5.5.62-0+deb8u1                            amd64        MySQL database client library
ii  libqt4-sql-mysql:amd64                  4:4.8.6+git64-g5dc8b2b+dfsg-3+deb8u1       amd64        Qt 4 MySQL database driver
ii  mysql-apt-config                        0.8.10-1                                   all          Auto configuration for MySQL APT Repo.
ii  mysql-common                            5.5.62-0+deb8u1                            all          MySQL database common files, e.g. /etc/mysql/my.cnf
ii  mysql-server-core-5.5                   5.5.62-0+deb8u1                            amd64        MySQL database server binaries
```
On s'aperçoit qu'une version 5.5 est installée sur la machine. Est-elle démarrée ou arrêtée ?
```
$ps aux | grep mysql
mdautrey  2799  0.1  0.1 2038620 38288 ?       Sl   20:30   0:00 /usr/sbin/mysqld --defaults-file=/home/mdautrey/.local/share/akonadi/mysql.conf --datadir=/home/mdautrey/.local/share/akonadi/db_data/ --socket=/tmp/akonadi-mdautrey.4Xe7Ph/mysql.socket
```
Elle est démarrée mais attachée à un socket linux local dans le cadre d'une application "akonadi". Akonadi est un logiciel de gestion personnel qui a dû s'installer en même temps que l'environnement KDE.

Si nous listons les ports, nous remarquons que le 3306 (port par défaut de Mysql) est fermé et qu'Akonadi est accroché à un socket local :
```
$ netstat -pln | grep sql
(Tous les processus ne peuvent être identifiés, les infos sur les processus
non possédés ne seront pas affichées, vous devez être root pour les voir toutes.)
unix  2      [ ACC ]     STREAM     LISTENING     27688    2799/mysqld         /tmp/akonadi-mdautrey.4Xe7Ph/mysql.socket
```
### Méthode choisie
Comme désinstaller akonadi est risqué, nous sommes liés par mysql-server5, ce qui nous conduit à installer directement la version proposée dans la distribution debian :
```
$ sudo apt-get install mysql-workbench
```
## Chargement du container mysql 8
Nous pouvons cependant, grâce à docker, charger et exécuter le container en version 8.
### Préparation des répertoires
Nous créons un répertoire local imiemysql ou nous logeons notre my.cnf et un répertoire pour les données du serveur mysql :
```
$mkdir imie_mysql
$cd imie_mysql/
~/imie_mysql$ mkdir conf.d
~/imie_mysql$ touch conf.d/config-file.cnf
~/imie_mysql/etc$ cd ..
~/imie_mysql$ mkdir data
```

### Montage des volumes et démarrage
Nous mappons les volumes correspondants et définissons notre méthode de démarrage de notre base de données :
```
docker run --name imie-mysql -v /home/mdautrey/imie_mysql/conf.d:/etc/mysql/conf.d  -v /home/mdautrey/imie_mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=imie -d mysql:8.0.13
```

### Bind address
Si l'on souhaite accéder au serveur depuis workbench, il faut le binder sur un port et une adrresse locale et ajouter un utilisateur pour accéder :
- le bind se fait d'abord dans la configuration
- le mapping de port se fait dans la commande docker

#### Bind extérieur du port
On ajoute l'option -p à la commande pour lancer docker :
```
docker run --name imie-mysql -p 3306:3306 -v /home/mdautrey/imie_mysql/conf.d:/etc/mysql/conf.d  -v /home/mdautrey/imie_mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=imie -d mysql:8.0.13
```


#### Ajout de l'utilisateur
On se connecte en shell sur le container, puis on exécute mysql et on ajoute l'utilisateur ad hoc avec les droits ad hoc
```
$ docker exec -it imie-mysql bash
/# mysql -u root -p
mysql> CREATE USER 'admin'@'%' IDENTIFIED WITH 'mysql_native_password' BY 'imie';
Query OK, 0 rows affected (0.13 sec)
mysql> GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;
Query OK, 0 rows affected (0.07 sec)
mysql> exit
Bye
/# exit
exit
```

#### Modification du fichier de configuration
Nous éditions le fichier de configuration sur l'hôte /home/mdautrey/imie_mysql/conf.d/config-file.cnf pour y ajouter les deux lignes suivantes :
```
[mysqld]
bind-address = 0.0.0.0
```
####
Nous redémarrons ensuite le container et faisons le test de connexion :
```
$ docker restart imie-mysql
$ mysql -h 127.0.0.1 -u admin -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.13 MySQL Community Server - GPL

Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```





