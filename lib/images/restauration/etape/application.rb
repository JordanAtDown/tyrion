# frozen_string_literal: true

require "logging"

module Restauration
  module Etape
    # Définit l'étape d'application
    class Application
      def initialize(exif_manipulateur)
        @exif_manipulateur = exif_manipulateur
        @log = Logging.logger[self]
      end
    
      def parcours(fichiers)
        fichiers.each_pair do |key, value|
          @log.debug "Application sur le fichier '#{key}'"
          if File.file?(key)
            begin
              @exif_manipulateur.set_datetimeoriginal(key, value.date)
              File.rename(key, value.path_nouveau_nom)
              FileUtils.mkdir_p(File.dirname(value.path_destination))
              FileUtils.move(value.path_nouveau_nom, value.path_destination)
            rescue ExifManipulateur::ExifManipulateurErreur => e
              @log.fatal e.message
            rescue SystemCallError => e
              @log.fatal e.message
            end
          else
            @log.warn "le fichier '#{key}' ne sera pas traite"
          end
        end
      end
    end
  end
end

