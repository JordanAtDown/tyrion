# frozen_string_literal: true

require "etape/analyse"

# Restauration
class Restauration
  attr_reader :analyse, :traitement_dossier_extirpable, :traitement_dossier_non_extirpable, :application

  def initialize(analyse, traitement_dossier_extirpable = nil, traitement_dossier_non_extirpable = nil, application = nil)
    @analyse = analyse
    @traitement_dossier_extirpable = traitement_dossier_extirpable
    @traitement_dossier_non_extirpable = traitement_dossier_non_extirpable
    @application = application
    @analyse.add_observer(self, :analyse_en_cours)
  end

  def process(dossier, analyse_uniquement)
    if analyse_uniquement
      @analyse.parcours(dossier)
    end
  end

  def analyse_en_cours(time, dossier_analyse)
    puts format("[Analyse] [%s] : Le dossier %s à été analyse à %s%%", time.strftime("%Y-%m-%d %H:%M:%S"), dossier_analyse.dossier, dossier_analyse.taux)
  end
end
