# frozen_string_literal: true

require "fileutils"

# Définit l'étape d'application
class ApplicationEtape
  def parcours(fichiers)
    fichiers.each_pair do |key, value|
      if File.file?(key)
        begin
          File.rename(key, value.get_nouveau_nom)
        rescue SystemCallError => e
          puts e.class
          puts e.message
          puts e.trace
        end
        FileUtils.move(value.get_nouveau_nom, value.get_path_nouveau_chemin)
      end
    end
  end
end
