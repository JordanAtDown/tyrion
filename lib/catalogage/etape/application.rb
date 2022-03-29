# frozen_string_literal: true

module Catalogage
  module Etape
    class Application
      def initialize(exif_manipulateur)
        @exif_manipulateur = exif_manipulateur
        @log = Logging.logger["Application"]
      end

      def applique(fichiers_par_dossier, destination)
        fichiers_par_dossier.each_pair do |dossier, fichiers|
          @log.debug "Application sur le dossier '#{dossier}'"
          destination_par_dossier = "#{destination}/#{dossier}"
          @log.info "destination '#{destination_par_dossier}'"
          fichiers.each do |fichier|
            @log.debug "Application sur le fichier '#{fichier.path}'"
            if !fichier.exif
              @exif_manipulateur.set_datetimeoriginal(fichier.path, fichier.date_extraite)
            end
            nouveau_nom = fichier.path_nouveau_nom(File.dirname(fichier.path))
            File.rename(fichier.path, nouveau_nom)
            FileUtils.mkdir_p(destination_par_dossier)
            FileUtils.move(nouveau_nom, fichier.path_nouveau_nom(destination_par_dossier))
          end
        end
      end
    end
  end
end
