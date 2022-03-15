# frozen_string_literal: true

require_relative "tyrion/version"
require "tyrion"
require "thor"
require "etape/analyse_etape"
require "etape/application_etape"
require "etape/traitement_dossier_extirpable_etape"
require "etape/traitement_dossier_non_extirpable_etape"
require "restauration"
require "extracteur_par_date"

module Tyrion
  # Cli
  class CLI < Thor
    desc "restore [path]", "Permet de restaurer les metadatas des photos"
    long_desc <<-LONGDESC
      Le paramétre --apply permet d'appliquer concretement la restauration des fichiers

      Restaure les metadatas de fichiers.

        - Extrait si possible la date du nom du fichier (ex: 20151231_155723_011 -> 2015/12/31 15h57m23s)

        - Extrait une date possible à partir de l'aborescence de l'emplacement (ex: 2012/01 -> 2012/01/01 00h00m00s)

        - Restaure la date de prise de vue qui est une metadata EXIF

        - Deplace les fichiers dans un sous-dossier extension (ex: 2012/01/JPG, 2015/05/PNG)
    LONGDESC
    option :apply, type: :boolean
    def restore(path)
      Restauration.new(
        AnalyseEtape.new(ExtracteurParDate.new),
        TraitementDossierExtirpableEtape.new(ExtracteurParDate.new),
        TraitementDossierNonExtirpableEtape.new,
        ApplicationEtape.new
      ).process(path, options[:apply])
    end
  end
end
