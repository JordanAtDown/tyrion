# frozen_string_literal: true

module Catalogage
  module Etape
    class Application
      def initialize(exif_manipulateur)
        @exif_manipulateur = exif_manipulateur
      end

      def applique(fichiers_par_dossier, destination)
        fichiers_par_dossier.each_pair do |dossier, fichiers|
          destination_par_dossier = "#{destination}/#{dossier}"
          fichiers.each do |fichier|
            if fichier.exif
              @exif_manipulateur.set_datetimeoriginal(fichier, fichier.date_extraite)
            end
            File.rename(fichier.path, fichier.path_nouveau_nom(File.dirname(fichier.path)))
            FileUtils.mkdir_p(destination_par_dossier)
            FileUtils.move(fichier.path_nouveau_nom(File.dirname(fichier.path)), fichier.path_nouveau_nom(destination_par_dossier))
          rescue ExifManipulateur::ExifManipulateurErreur => e
            puts e.message
          rescue SystemCallError => e
            puts e.message
          end
        end
      end
    end
  end
end
