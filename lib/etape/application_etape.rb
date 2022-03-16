# frozen_string_literal: true

require "observer"
require "fileutils"

# Définit l'étape d'application
class ApplicationEtape
  include Observable
  
  attr_reader :exif_manipulateur

  def initialize(exif_manipulateur = nil)
    @exif_manipulateur = exif_manipulateur
  end

  def parcours(fichiers)
    fichiers.each_pair do |key, value|
      if File.file?(key)
        begin
          File.rename(key, value.path_nouveau_nom)
          FileUtils.mkdir_p(File.dirname(value.path_destination))
          FileUtils.move(value.path_nouveau_nom, value.path_destination)
        rescue SystemCallError => e
          puts e.class
          puts e.message
          puts e.trace
        end
      end
    end
  end
end
