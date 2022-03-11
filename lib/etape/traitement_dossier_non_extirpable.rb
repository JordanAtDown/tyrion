# frozen_string_literal: true

require "etape/fichier"
require "dedoublonneur"
require "directory"

# Définit l'étape de traitement de dossier non extirpable
class TraitementDossierNonExtirpableEtape
  attr_reader :fichiers

  def initialize(fichiers = {})
    @fichiers = fichiers
  end

  def parcours(dossier)
    dedoublonneur = Dedoublonneur.new
    Dir.glob(dossier) do |fichier|
      if File.file?(fichier)
        numero_attribue = dedoublonneur.attribution_par_numero
        fichiers.merge!({ fichier => Fichier.new(numero_attribue, Directory.get_date(File.dirname(fichier)), fichier.path, File.extname(fichier)) })
      else
        parcours("#{fichier}/*")
        next
      end
    end
  end
end
