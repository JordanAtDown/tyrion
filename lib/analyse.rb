# frozen_string_literal: true

# Definition des dossiers analysable
class Analyse
  attr_reader :dossiers

  def initialize(dossiers = [])
    @dossiers = dossiers
  end

  def calcul_taux_analyse
    fichier_par_analyse_possible = @dossiers.tally
    if fichier_par_analyse_possible.key?(true)
      ((fichier_par_analyse_possible[true] * 100) / @dossiers.length)
    else
      0
    end
  end
end
