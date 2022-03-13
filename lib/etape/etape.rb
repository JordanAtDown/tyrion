# frozen_string_literal: true

require "analyseur"

# Definition des dossiers analysable
# [ "chemin/dossier/analyse" => [true, false, true] ]
class Analyse
  attr_accessor :dossiers
  attr_reader :analyseur

  def initialize(dossiers = {}, analyseur)
    @dossiers = dossiers
    @analyseur = analyseur
  end

  def calcul_taux_analyse_pour(dossier)
    fichiers_analyse = @dossiers.fetch(dossier)
    fichier_par_analyse_possible = @dossiers.fetch(dossier).tally
    if fichier_par_analyse_possible.key?(true)
      ((fichier_par_analyse_possible[true] * 100) / fichiers_analyse.length)
    else
      0
    end
  end

  def analyse_fichier(dossier, fichier)
    if @dossiers.key?(dossier)
      @dossiers.merge!({ dossier => @dossiers
        .fetch(dossier)
        .push(analyseur.est_analysable(fichier)) })
    else
      @dossiers.merge!({ dossier => [].push(analyseur.est_analysable(fichier)) })
    end
  end
end
