# Tyrion

Tyrion est un interpréteur de command permettant d'exécuter différentes tâches. Les différentes tâches qui sont implémentés sont :

* La réparation d'un dossier contenant photos et vidéo pour appliquer une structure, nommage et metadata correcte
* Le catalogague de photo et vidéo

## Installation

Exécuter :

    $ bundle install

## Usage

Tyrion est un CLI. Les commandes implémentés actuellement sont : 

    > $ tyrion restore "/mnt/d/backup/Vault"

    > $ tyrion catalog "/mnt/d/backup/camera" "/mnt/d/backup/Vault"

La documentation de chacune des commandes est disponible

    > $ tyrion help [command] 

## Développement

Aprés avoir récupéré le repository, exécuter `bin/setup` pour installer les dépendances. Puis lancer `rake spec` pour exécuter les tests automatisés.

Pour installer cette gem sur la machine, exécuter `bundle exec rake install`. 
Pour release une nouvelle version, mettre à jour le numéro de version dans `version.rb`, puis exécuter `bundle exec rake release` ce qui crée un nouveau tag git pour la version, push les commit et crée un tag et push le `.gem` vers [rubygems.org](https://rubygems.org).

