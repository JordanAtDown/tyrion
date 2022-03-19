# frozen_string_literal: true

require "logging"

require "etape/fichier"
require "dedoublonneur"

# Définit l'étape de traitement de dossier extirpable
class TraitementDossierExtirpableEtape
  attr_reader :fichiers

  def initialize(extracteur, fichiers = {})
    @extracteur = extracteur
    @fichiers = fichiers
    @log = Logging.logger[self]
  end

  def parcours(dossiers)
    @log.info "Traitement sur le dossier '#{dossiers}'"
    dossiers.each do |dossier|
      dedoublonneur = Dedoublonneur.new
      Dir.each_child(dossier) do |nom_fichier|
        begin
          fichier = "#{dossier}/#{nom_fichier}"
          @log.debug "Traitement sur le fichier '#{fichier}'"
          date_extraite = @extracteur.extraction_du(File.basename(fichier, File.extname(fichier)))
          nom_attribue = dedoublonneur.dedoublonne_par_numerotation(date_extraite.strftime("photo_%Y_%m_%d-%H_%M_%S"))
          fichiers.store(fichier,
                        Fichier.new(nom_attribue, date_extraite, File.dirname(fichier), File.extname(fichier)))
        rescue ExtractionErreur => e
          @log.error e.message
        end
      end
    end
  end
end
