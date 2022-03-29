# frozen_string_literal: true

require "thor"
require "date"

require_relative "tyrion/version"
require "tyrion"

require "configuration"
require "startup_configurator"
require "commande_nom"

require "images/catalogage/catalog"
require "images/catalogage/etape/analyse"
require "images/catalogage/etape/application"
require "images/catalogage/etape/nom_attribuer"
require "images/catalogage/etape/verificateur"

require "images/restauration/etape/analyse_etape"
require "images/restauration/etape/application_etape"
require "images/restauration/etape/traitement_dossier_extirpable_etape"
require "images/restauration/etape/traitement_dossier_non_extirpable_etape"
require "images/restauration/restore"

require "images/exif/mini_exiftool_manipulateur"

require "extracteur_par_date"

module Tyrion
  # Cli
  class CLI < Thor
    desc "restore [path_dossier]", "Permet de restaurer les metadatas des fichiers"
    long_desc <<-LONGDESC

      Exemple d'utilisation

      > $ tyrion restore "/mnt/d/backup/Vault" --log "/tmp/tyrion" --level "warn" --apply

      les paramétres :

        [log, l] : permet de définir l'emplacement où sera verser le fichier 'tyrion_restore_yyy_mm_dd-hh_mm_ss.log' (ex : "/tmp/tyrion"), si il n'existe pas il sera crée

        [level, lvl] : permet de définir le niveau de log (debug, info, warn, error, fatal) à afficher par défaut il est défini à 'info'

        [apply, a] : permet d'appliquer la restauration des metadata

      Parcours un dossier dans une arborescence défini "Vault/annee/mois/*.jpg,*.png,*.mp4" (ex: Vault/2021/01)

      Restaure les metadatas de fichiers d'après les régles suivantes.

        - Extrait la date du nom du fichier (ex: 20151231_155723_011 -> 2015/12/31 15h57m23s)

        - Extrait une date possible à partir de l'arborescence de l'emplacement (ex: 2012/01 -> 2012/01/01 00h00m00s)

        - Renomme les fichiers suivant le pattern suivant (photo_YYYY_MM_JJ-HH_MM_SS.*|video_YYYY_MM_JJ-HH_MM_SS.*) quand une date peut en être extrait

        - Renomme par numérotation 001.*, 002.*, ... si aucun fichier contenu dans le dossier ANNEE/MOIS ne peux être extrait une date

        - Restaure la date de prise de vue (date_time_orirignal) qui est une metadata EXIF

        - Deplace les fichiers dans un sous-dossier par extension (ex: 2012/01/JPG, 2015/05/PNG)
    LONGDESC
    option :log, type: :string, default: "", aliases: :l
    option :level, type: :string, default: "info", aliases: :lvl
    option :apply, type: :boolean, default: false, aliases: :a
    def restore(path_dossier)
      StartupConfigurator.builder(DateTime.now, CommandeNom::RESTORE_CMD, "tyrion")
                         .set_log_level(options[:level])
                         .set_log_file(options[:log])
                         .startup
      Restauration.new(
        AnalyseEtape.new(ExtracteurParDate.new),
        TraitementDossierExtirpableEtape.new(ExtracteurParDate.new),
        TraitementDossierNonExtirpableEtape.new,
        ApplicationEtape.new(MiniExiftoolManipulateur.new),
        Configuration.new(options[:apply], "")
      ).process(path_dossier)
    end

    desc "catalog [path_dossier] [destination]", "Permet de trier et ranger les fichiers d'un dossier vers un autre"
    long_desc <<-LONGDESC

      Exemple d'utilisation

      > $ tyrion catalog "/mnt/d/backup/camera" "/mnt/d/backup/Vault" --log "/tmp/tyrion" --level "warn" --apply

      les paramétres :

        [log, l] : permet de définir l'emplacement où sera verser le fichier 'tyrion_catalog_yyy_mm_dd-hh_mm_ss.log' (ex : "/tmp/tyrion"), si il n'existe pas il sera crée

        [level, lvl] : permet de définir le niveau de log (debug, info, warn, error, fatal) à afficher par défaut il est défini à 'info'

        [apply, a] : permet d'appliquer le catalogage, renommage et déplacé les fichiers


      Fonctionnement :


        Parcours un dossier pour définir si un fichier posséde des metadata exif ou que l'extraction de son nom permet d'extraire une date

        Puis renomme est déplace les fichiers par arborescence 'annee/mois/extension' dans un dossier de destination

        Vérifie que le dossier de destination ne contient aucun conflit de nommage.CLI

        Si il existe des conflit de nommage le rapport de log générera les conflits du dossier destinataire
        et n'appliquera aucune modification aux fichiers source
    LONGDESC
    option :log, type: :string, default: "", aliases: :l
    option :level, type: :string, default: "info", aliases: :lvl
    option :apply, type: :boolean, default: false, aliases: :a
    def catalog(path_dossier, destination)
      StartupConfigurator.builder(DateTime.now, CommandeNom::CATALOG_CMD, "tyrion")
                         .set_log_level(options[:level])
                         .set_log_file(options[:log])
                         .startup

      FileUtils.mkdir_p(destination) unless Dir.exist?(destination)

      raise unless Dir.exist?(path_dossier)

      configuration = Configuration.new(options[:apply], destination)

      Catalogage::Cataloger.new(
        Catalogage::Etape::Analyse.new(ExtracteurParDate.new, MiniExiftoolManipulateur.new),
        Catalogage::Etape::NomAttribuer.new,
        Catalogage::Etape::Application.new(MiniExiftoolManipulateur.new),
        Catalogage::Etape::Verificateur.new
      ).process(path_dossier, configuration)
    end
  end
end
