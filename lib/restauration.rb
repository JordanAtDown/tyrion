# frozen_string_literal: true

# Restauration
class Restauration
  def initialize(analyse, traitement_dossier_extirpable, traitement_dossier_non_extirpable, application, configuration)
    @analyse = analyse
    @traitement_dossier_extirpable = traitement_dossier_extirpable
    @traitement_dossier_non_extirpable = traitement_dossier_non_extirpable
    @application = application
    @configuration = configuration
  end

  def process(dossier)
    @analyse.parcours(dossier)

    dossiers_extirpable = @analyse.dossiers_analyses.select { |_key, value| value == 100 }.keys
    @traitement_dossier_extirpable.parcours(dossiers_extirpable)

    dossiers_non_extirpable = @analyse.dossiers_analyses.select { |_key, value| value < 100 }.keys
    @traitement_dossier_non_extirpable.parcours(dossiers_non_extirpable)

    all_fichiers = @traitement_dossier_extirpable.fichiers.merge(@traitement_dossier_non_extirpable.fichiers)
    @application.parcours(all_fichiers) if @configuration.apply
  end
end
