# frozen_string_literal: true

require_relative "tyrion/version"

require "tyrion"
require "thor"

require "etape/analyse"

require "restauration"
require "extracteur_par_date"

module Tyrion
  # Cli
  class CLI < Thor
    desc "restore [path]", "Permet de restaurer les metadatas des photos"
    long_desc <<-LONGDESC
      Restaure les metadatas de fichiers de type photos.

        - Extrait si possible la date du nom du fichier (ex: 20151231_155723_011 -> 2015/12/31 15h57m23s)

        - Extrait une date possible à partir de l'aborescence de l'emplacement (ex: 2012/01 -> 2012/01/01 00h00m00s)

        - Restaure la date de prise de vue

        - Deplace les fichiers dans un sous-dossier extension (ex: 2012/01/JPG, 2015/05/PNG)
    LONGDESC
    option :analyse, :type => :boolean
    def restore(path)
      Restauration.new(AnalyseEtape.new(ExtracteurParDate.new)).process(path, options[:analyse])
    end
  end
end
