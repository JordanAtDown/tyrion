# frozen_string_literal: true

# Restauration
class Restauration
  attr_reader :analyse, :traitement_dossier_extirpable, :traitement_dossier_non_extirpable, :application

  def initialize(analyse, traitement_dossier_extirpable = nil, traitement_dossier_non_extirpable = nil, application = nil)
    @analyse = analyse
    @traitement_dossier_extirpable = traitement_dossier_extirpable
    @traitement_dossier_non_extirpable = traitement_dossier_non_extirpable
    @application = application
    @analyse.add_observer(self, :analyse_en_cours)
    @traitement_dossier_extirpable.add_observer(self, :traitement_dossier_extirpable_en_cours)
    @traitement_dossier_non_extirpable.add_observer(self, :traitement_dossier_non_extirpable_en_cours)
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

  def traitement_dossier_extirpable_en_cours(time, traitement_notification)
    puts format("[Traitement][Extirpable] [%s] : traitement sur le fichier '%s'",
                time.strftime("%Y-%m-%d %H:%M:%S"), traitement_notification.nom_fichier)
  end

  def traitement_dossier_non_extirpable_en_cours(time, traitement_notification)
    puts format("[Traitement][Non Extirpable] [%s] : traitement sur le fichier '%s'",
                time.strftime("%Y-%m-%d %H:%M:%S"), traitement_notification.nom_fichier)
  end

  def analyse_en_cours(time, dossier_analyse)
    puts format("[Analyse] [%s] : Le dossier %s à été analyse à %s%%", time.strftime("%Y-%m-%d %H:%M:%S"),
                dossier_analyse.dossier, dossier_analyse.taux)
  end
end
