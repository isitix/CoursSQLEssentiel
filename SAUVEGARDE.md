# Sauvegarde de la base de données
## Paramètres de sauvegarde :
### Objectifs
- RPO : Recovery Point Objective
- RTO : Recovery Time Objective

### Stratégies 
- Full : toutes les données
- Differential : les données depuis la dernière full
- Incremential : les données depuis la dernière full, la dernière incrémentielle ou la dernière différentielle

Stratégie possible :
- une full par mois
- une différentiel par semaine
- une incrémentiel par semaine

Conservation des 12 dernières full, des 12 dernières différentielles et des 12 dernières incrémentielles

## Contraintes
- Sauvegarde à chaud : serveur utilisé par des utilisateurs avec la problématique des tansactions et des écritures en cours
- Sauvegarde à froid : serveur arrêté, plus simple, mais arrêt de l'application, plage de maintenance

## Architecture de sauvegarde
De nombreux outils sont disponibles. Les outils les plus performants sont souvent associés à des licences payantes. On peut distinguer trois méthodes principales de sauvegarde :
- sauvegarde au niveau bloc : recopier les blocs d'un disque ou d'une unité de stockage
- sauvegarde au niveau fichier : recopier les fichiers utilisés par le serveur de base de données
- sauvegarde au niveau logique : utilisation d'un outil propre à la base de données pour produire un fichier soit de type script SQL soit dans un format propriétaire propre à l'éditeur de la base de données

L'architecture choisie dépend beaucoup de l'architecture du système :
- Présence de baies de stockage
- Hyperviseur type VMWare
- ...

On préconise généralement trois supports de sauvegarde distincts, si possible à des formats et des emplacements géographiques distincts :
- Disque dur
- Lecteur de bande (LTO)
- Cloud
...

Enfin, il est possible de répliquer le serveur de bases de données, en mode maitre-esclave, et de sauvegarder le réplicat :
- Pas d'impact sur la production
- Possibilité d'un réplicat distant

### Test des sauvegardes
Des tests des sauvegardes doivent être réalisés périodiquement :
- Vérifier l'état du fichier de sauvegarde
- Vérifier les logs du processus de sauvegarde
- Rejouter la sauvegarde

## Sauvegarde de Mysql
### Remarques générales
Les outils les plus performants sont dans la version entreprise, payante.

Deux solutions principales sont proposées
- Copie des fichiers de la base de données en sauvegarde à froid
- Utilisation de mysqldump (en mode locké ou pas)

### Copie à froid des fichiers de la base
- Arrêter le serveur
- Repérer l'emplacement du répertoire data (C:\ProgramData\MySQL\MySQL Server8.0\data sous Windows)
- Repérer le sous-répertoire correspondant à la base que l'on souhaite sauvegarder (employees dans notre cas)
- Copier le répertoire vers un répertoire de sauvegarde
- Redémarrer le serveur

Pour restaurer

## Sauvegarde logique à chaud avec Mysqldump
- Créer un répertoire pour ranger les fichiers de sauvegarde
- Ouvrir un shell (CMD)
- Se positionner dans le répertoire de sauvegarde
- Lancer la commande
```
myqldump -h localhost -u root -p --databases employees > 2018-11-26-1122-employees.sql
```

Pour la restauration, procéder comme pour le lancement d'un script sur la base de données, après s'être positionné dans le répertoire où se trouve la sauvegarde :
```
mysql -h localhost -u root -p < 2018-11-26-1122-employees.sql
```


