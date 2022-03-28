# frozen_string_literal: true

module Catalogage
  module Etape
    # Permet de vérifier les fichiers en conflit dans la destination
    class Verificateur
      
      def initialize(index_fichiers_destination = [], index_fichiers_analyses = [], fichiers_conflit = {})
        @index_fichiers_destination = index_fichiers_destination
        @index_fichiers_analyses = index_fichiers_analyses
        @fichiers_conflit = fichiers_conflit
      end

      def index(fichiers_analyses, destination)
        index_destination(destination)
        index_fichiers_analyses(fichiers_analyses, destination)
        @index_fichiers_analyses.each do |fichier_analyse|
          @fichiers_conflit.store(fichier_analyse, @index_fichiers_destination.include?(fichier_analyse))
        end
      end

      def conflit?
        true
      end

      private

      def index_fichiers_analyses(fichiers_analyses, path_destination)
        fichiers_analyses.each_value do |fichiers|
          fichiers.each do |fichier|
            index_fichiers_analyses.push fichier.path_nouveau_nom("#{path_destination}/#{fichier.path_destination}")
          end
        end
      end

      def index_destination(destination)
        Dir.each_child(destination) do |nom_fichier|
          fichier = "#{dossier}/#{nom_fichier}"
          if File.file?(fichier)
            if File.extname(fichier) =~ EXTENSIONS_EXCLUS
              index_fichiers_destination.push fichier
            end
          else
            parcours(fichier)
            next
          end
        end
      end
    end
  end
end
