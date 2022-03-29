# frozen_string_literal: true

require "images/helpers/directory_helpers"
require "images/classification/classification"


module Restauration
  # Fichier
  class Fichier
    attr_reader :nom_attribue, :date, :path, :extension, :type
  
    def initialize(nom_attribue, date, path, extension)
      @nom_attribue = nom_attribue
      @date = date
      @path = path
      @extension = extension
      @type = Classification.get_type(extension)
    end
  
    def path_nouveau_nom
      "#{@path}/#{@nom_attribue}#{@extension.downcase}"
    end
  
    def path_destination
      "#{@path}/#{DirectoryHelpers.defini_dossier_par(@extension)}/#{@nom_attribue}#{@extension.downcase}"
    end
  end  
end

