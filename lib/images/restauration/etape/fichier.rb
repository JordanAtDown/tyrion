# frozen_string_literal: true

require "dossier_par_extension"
require "classificateur_par_extension"

# Fichier
class Fichier
  attr_reader :nom_attribue, :date, :path, :extension, :type

  def initialize(nom_attribue, date, path, extension)
    @nom_attribue = nom_attribue
    @date = date
    @path = path
    @extension = extension
    @type = ClassificateurParExtensions.get_type(extension)
  end

  def path_nouveau_nom
    "#{@path}/#{@nom_attribue}#{@extension.downcase}"
  end

  def path_destination
    "#{@path}/#{DossierParExtension.defini_dossier_par(@extension)}/#{@nom_attribue}#{@extension.downcase}"
  end
end
