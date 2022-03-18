# frozen_string_literal: true

# Restauration
class Restauration
  def initialize(analyse, traitement_dossier_extirpable, traitement_dossier_non_extirpable, application, configuration)
    @analyse = analyse
    @traitement_dossier_extirpable = traitement_dossier_extirpable
    @traitement_dossier_non_extirpable = traitement_dossier_non_extirpable
    @application = application
    @configuration = configuration
    @analyse.add_observer(self, :analyse_notifie)
    @traitement_dossier_extirpable.add_observer(self, :traitement_notifie)
    @traitement_dossier_non_extirpable.add_observer(self, :traitement_notifie)
    @application.add_observer(self, :application_notifie)
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

  def application_notifie(time, traitement_notification); end

  def traitement_notifie(time, traitement_notification); end

  def analyse_notifie(time, analyse_notification); end
end
