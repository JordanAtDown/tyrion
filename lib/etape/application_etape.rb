# frozen_string_literal: true

require "observer"
require "fileutils"

# Définit l'étape d'application
class ApplicationEtape
  include Observable
  
  def parcours(fichiers)
    fichiers.each_pair do |key, value|
      if File.file?(key)
        begin
          File.rename(key, value.path_nouveau_nom)
        rescue SystemCallError => e
          puts e.class
          puts e.message
          puts e.trace
        end
        FileUtils.move(value.path_nouveau_nom, value.path_destination)
      end
    end
  end
end
