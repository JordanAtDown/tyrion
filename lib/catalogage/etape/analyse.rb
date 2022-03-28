# frozen_string_literal: true

require "catalogage/etape/fichier"

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
      end

      def analyser(dossier)
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
              end
              ajoute_analyse Fichier.new(fichier, File.extname(fichier), date_extraite, exif)
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
              .push(fichier_analyse)
            })
        else
          @fichiers_analyses.store(path_destination, [].push(fichier_analyse))
        end
      end
    end
  end
end
