# frozen_string_literal: true

# Restauration
class Restauration
  attr_reader :analyse, :traitement_dossier_extirpable, :traitement_dossier_non_extirpable, :application

  def initialize(analyse, traitement_dossier_extirpable = nil, traitement_dossier_non_extirpable = nil, application = nil)
    @analyse = analyse
    @traitement_dossier_extirpable = traitement_dossier_extirpable
    @traitement_dossier_non_extirpable = traitement_dossier_non_extirpable
    @application = application
    @analyse.add_observer(self, :analyse_notifie)
    @traitement_dossier_extirpable.add_observer(self, :traitement_notifie)
    @traitement_dossier_non_extirpable.add_observer(self, :traitement_notifie)
    @application.add_observer(self, :application_notifie)
  end

  def process(dossier, applique)
    @analyse.parcours(dossier)
    dossiers_extirpable = @analyse.dossiers_analyses.select { |_key, value| value == 100 }
    dossiers_non_extirpable = @analyse.dossiers_analyses.select { |_key, value| value < 100 }
    @traitement_dossier_non_extirpable.parcours(dossiers_non_extirpable.keys)
    @traitement_dossier_extirpable.parcours(dossiers_extirpable.keys)
    if applique
      @application.parcours(@traitement_dossier_extirpable.fichiers.merge(@traitement_dossier_non_extirpable.fichiers))
    end
  end

  def application_notifie(time, traitement_notification)
    puts format("[Traitement][Extirpable] [%s] : traitement sur le fichier '%s'",
                time.strftime("%Y-%m-%d %H:%M:%S"), traitement_notification.nom_fichier)
  end

  def traitement_notifie(time, traitement_notification)
    puts format("[Traitement][Extirpable] [%s] : traitement sur le fichier '%s'",
                time.strftime("%Y-%m-%d %H:%M:%S"), traitement_notification.nom_fichier)
  end

  def analyse_notifie(time, analyse_notification)
    puts format("[Analyse] [%s] : Le dossier %s à été analyse à %s%%", time.strftime("%Y-%m-%d %H:%M:%S"),
                analyse_notification.dossier, analyse_notification.taux)
  end
end
