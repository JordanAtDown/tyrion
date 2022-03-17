# frozen_string_literal: true

require "observer"

require "notification/traitement_notification"
require "etape/fichier"
require "dedoublonneur"
require "directory"

# Définit l'étape de traitement de dossier non extirpable
class TraitementDossierNonExtirpableEtape
  include Observable

  attr_reader :fichiers

  def initialize(fichiers = {})
    @fichiers = fichiers
  end

  def parcours(dossiers)
    dossiers.each do |dossier|
      changed
      notify_observers(Time.now, TraitementNotification.new(fichier))
      dedoublonneur = Dedoublonneur.new
      Dir.each_child(dossier) do |nom_fichier|
        fichier = "#{dossier}/#{nom_fichier}"
        if File.file?(fichier)
          numero_attribue = dedoublonneur.attribution_par_numero
          fichiers.store(
            fichier,
            Fichier.new(numero_attribue,
              Directory.get_date(File.dirname(fichier)),
              File.dirname(fichier),
              File.extname(fichier)))
          notify_observers(Time.now, TraitementNotification.new(fichier))
        else
          notify_observers(Time.now, TraitementNotification.new(fichier))
        end
      end
    end
  end
end
