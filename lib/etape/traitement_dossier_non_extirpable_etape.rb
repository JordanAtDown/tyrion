# frozen_string_literal: true

require "logging"

require "etape/fichier"
require "dedoublonneur"
require "directory"

# Définit l'étape de traitement de dossier non extirpable
class TraitementDossierNonExtirpableEtape
  attr_reader :fichiers

  def initialize(fichiers = {})
    @fichiers = fichiers
    @log = Logging.logger[self]
  end

  def parcours(dossiers)
    @log.info "Traitement sur le dossier '#{dossiers}'"
    dossiers.each do |dossier|
      dedoublonneur = Dedoublonneur.new
      Dir.each_child(dossier) do |nom_fichier|
        fichier = "#{dossier}/#{nom_fichier}"
        @log.debug "Traitement sur le fichier '#{fichier}'"
        if File.file?(fichier)
          numero_attribue = dedoublonneur.attribution_par_numero
          fichiers.store(
            fichier,
            Fichier.new(
              numero_attribue, Directory.get_date(File.dirname(fichier)),
              File.dirname(fichier), File.extname(fichier)
            )
          )
        else
          @log.warn "le fichier '#{fichier}' ne sera pas traite"
        end
      end
    end
  end
end
