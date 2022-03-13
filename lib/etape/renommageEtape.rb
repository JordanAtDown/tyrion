# frozen_string_literal: true

require "renommeur"

# Definition des analysable
class RenommageEtape
  attr_accessor :analyseur
  attr_reader :fichiers

  def initialize(analyseur, fichiers = {})
    @analyseur = analyseur
    @fichiers = fichiers
  end

  def parcours(dossier)
    renommeur = Renommeur.new
    Dir.glob(dossier) do |fichier|
      if File.file?(fichier)
        date_extraite = analyseur.analyse(fichier)
        nom_attribue = renommeur.numerotation(date_extraite.strftime("photo_%Y_%m_%d-%Y_%m_%d"))
        fichiers.merge!({ fichier => Fichier.new(nom_attribue, date_extraite) })
      else
        parcours("#{fichier}/*")
        next
      end
    end
  end
end

# Fichier
class Fichier
  attr_reader :nom_attribue, :date

  def initialize(nom_attribue, date)
    @nom_attribue = nom_attribue
    @date = date
  end
end
