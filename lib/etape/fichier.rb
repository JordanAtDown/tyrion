# frozen_string_literal: true

# Fichier
class Fichier
  attr_reader :nom_attribue, :date, :path, :extension

  def initialize(nom_attribue, date, path, extension)
    @nom_attribue = nom_attribue
    @date = date
    @path = path
    @extension = extension
  end

  def get_nouveau_nom
    "#{@path}#{@nom_attribue}.#{extension}"
  end
end
