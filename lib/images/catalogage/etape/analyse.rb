# frozen_string_literal: true

require "images/catalogage/etape/fichier"

module Catalogage
  module Etape
    # Analyse
    class Analyse
      attr_reader :fichiers_analyses

      EXTENSIONS_EXCLUS = /\.(?!(ini|log|1|db-shm|db-wal|db)$)([^.]+$)/.freeze

      def initialize(extracteur, exif_manipulateur, fichiers_analyses = {})
        @extracteur = extracteur
        @exif_manipulateur = exif_manipulateur
        @fichiers_analyses = fichiers_analyses
        @log = Logging.logger["Analyse"]
      end

      def analyser(dossier)
        @log.debug "Parcours du dossier '#{dossier}'"
        Dir.each_child(dossier) do |nom_fichier|
          fichier = "#{dossier}/#{nom_fichier}"
          if File.file?(fichier)
            if File.extname(fichier) =~ EXTENSIONS_EXCLUS
              date_extraite = nil
              exif = false
              if @exif_manipulateur.datetimeoriginal?(fichier)
                date_extraite = @exif_manipulateur.get_datetimeoriginal(fichier)
                exif = true
              elsif @extracteur.extirpabilite(fichier)
                date_extraite = @extracteur.extraction_du(File.basename(fichier, File.extname(fichier)))
              else
                @log.warn "Aucune date extraire pour le fichier '#{fichier}'"
              end
              @log.debug "Le fichier '#{fichier}' à une date extraite au #{date_extraite}"
              @log.debug "La date extraite viens des metadata 'datetimeoriginal' : #{exif ? "oui" : "non"}"
              ajoute_analyse Fichier.new(fichier, File.extname(fichier), date_extraite, exif)
            else
              @log.warn "Le fichier '#{fichier}' ne sera pas analysé"
            end
          else
            analyser(fichier)
            next
          end
        end
      end

      private

      def ajoute_analyse(fichier_analyse)
        path_destination = fichier_analyse.path_destination
        if @fichiers_analyses.key?(path_destination)
          @fichiers_analyses.merge!({ path_destination =>
              @fichiers_analyses
              .fetch(path_destination)
              .push(fichier_analyse) })
        else
          @fichiers_analyses.store(path_destination, [].push(fichier_analyse))
        end
        @log.info "Le fichier '#{fichier_analyse.path}' sera versé vers #{path_destination}"
      end
    end
  end
end
