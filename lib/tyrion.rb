# frozen_string_literal: true

require "thor"

require_relative "tyrion/version"
require "tyrion"
require "startup"
require "etape/analyse_etape"
require "etape/application_etape"
require "etape/traitement_dossier_extirpable_etape"
require "etape/traitement_dossier_non_extirpable_etape"
require "exif/mini_exiftool_manipulateur"
require "restauration"
require "extracteur_par_date"

module Tyrion
  # Cli
  class CLI < Thor
    desc "restore [path]", "Permet de restaurer les metadatas des fichiers"
    long_desc <<-LONGDESC

      Exemple d'utilisation

      > $ tyrion restore "/mnt/d/backup/Vault" --log "/tmp/tyrion" --level "war" --apply

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
    option :log, :type => :string, :default => "", :aliases => :l
    option :level, :type => :string, :default => "info", :aliases => :lvl
    option :apply, :type => :boolean, :default => false, :aliases => :a
    def restore(path)
      level = Startup.log_level(options[:level])
      dossier_log = Startup.cree_le(options[:log])

      Restauration.new(
        AnalyseEtape.new(ExtracteurParDate.new),
        TraitementDossierExtirpableEtape.new(ExtracteurParDate.new),
        TraitementDossierNonExtirpableEtape.new,
        ApplicationEtape.new(MiniExifToolManipulateur::ExifManipulateur.new),
        Startup::Configuration.new(options[:apply], level, dossier_log, Startup::RESTORE_CMD, DateTime.now)
      ).process(path)
    end
  end
end
