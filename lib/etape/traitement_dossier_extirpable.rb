# frozen_string_literal: true

require "etape/fichier"
require "dedoublonneur"

# Définit l'étape de traitement de dossier extirpable
class TraitementDossierExtirpableEtape
  attr_accessor :extracteur
  attr_reader :fichiers

  def initialize(extracteur, fichiers = {})
    @extracteur = extracteur
    @fichiers = fichiers
  end

  def parcours(dossier)
    dedoublonneur = Dedoublonneur.new
    Dir.glob(dossier) do |fichier|
      if File.file?(fichier)
        date_extraite = extracteur.extraction_du(fichier)
        nom_attribue = dedoublonneur.dedoublonne_par_numerotation(date_extraite.strftime("photo_%Y_%m_%d-%H_%M_%S"))
        fichiers.merge!({ fichier => Fichier.new(nom_attribue, date_extraite, File.dirname(fichier), File.extname(fichier)) })
      else
        parcours("#{fichier}/*")
        next
      end
    end
  end
end
