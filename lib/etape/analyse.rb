# frozen_string_literal: true

require "analyseur"

# Definition des dossiers analysable
class Analyse
  attr_reader :dossiers
  attr_reader :analyseur

  def initialize(dossiers = {}, analyseur)
    @dossiers = dossiers
    @analyseur = analyseur
  end

  def calcul_taux_analyse_pour(dossier)
    # test = @dossiers
    # fichier_par_analyse_possible = @dossiers.fetch(dossier).tally
    # if fichier_par_analyse_possible.key?(true)
    #   ((fichier_par_analyse_possible[true] * 100) / @dossiers.length)
    # else
    #   0
    # end
    0
  end

  def analyse_fichier(dossier, fichier)
    @dossiers.merge!({ nom => @dossiers
      .fetch(dossier)
      .push(analyseur.est_analysable(fichier)) })
  end
end
