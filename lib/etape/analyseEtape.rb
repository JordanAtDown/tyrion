# frozen_string_literal: true

require "analyseur"

# Definition des dossiers analysable
class AnalyseEtape
  attr_accessor :dossiers_analyses
  attr_reader :nom_fichiers_analyses_par_dossier
  attr_reader :analyseur

  def initialize(analyseur, nom_fichiers_analyses_par_dossier = {}, dossiers_analyses = {})
    @analyseur = analyseur
    @nom_fichiers_analyses_par_dossier = nom_fichiers_analyses_par_dossier
    @dossiers_analyses = dossiers_analyses
  end

  def parcours(dossier)
    Dir.glob(dossier) do |fichier|
      if File.file?(fichier)
        analyse_par(dossier, fichier)
      else
        parcours("#{fichier}/*")
        next
      end
    end
    @dossiers_analyses.merge!({ dossier => calcul_taux_analyse_pour(dossier) }) if @nom_fichiers_analyses_par_dossier.key?(dossier)
  end

  def calcul_taux_analyse_pour(nom_dossier)
    fichiers_analyse = @nom_fichiers_analyses_par_dossier.fetch(nom_dossier)
    fichier_par_analyse_possible = @nom_fichiers_analyses_par_dossier.fetch(nom_dossier).tally
    if fichier_par_analyse_possible.key?(true)
      ((fichier_par_analyse_possible[true] * 100) / fichiers_analyse.length)
    else
      0
    end
  end

  def analyse_par(path_dossier, nom_fichier)
    if @nom_fichiers_analyses_par_dossier.key?(path_dossier)
      @nom_fichiers_analyses_par_dossier.merge!({ path_dossier => @nom_fichiers_analyses_par_dossier
        .fetch(path_dossier)
        .push(analyseur.est_analysable(nom_fichier)) })
    else
      @nom_fichiers_analyses_par_dossier.merge!({ path_dossier => [].push(analyseur.est_analysable(nom_fichier)) })
    end
  end
end
