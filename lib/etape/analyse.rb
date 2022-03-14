# frozen_string_literal: true

# Definit l'étape d'analyse
class AnalyseEtape
  attr_accessor :dossiers_analyses
  attr_reader :noms_extirpable_par_dossier, :extracteur

  def initialize(extracteur, noms_extirpable_par_dossier = {}, dossiers_analyses = {})
    @extracteur = extracteur
    @noms_extirpable_par_dossier = noms_extirpable_par_dossier
    @dossiers_analyses = dossiers_analyses
  end

  def parcours(dossier)
    Dir.glob(dossier) do |fichier|
      if File.file?(fichier)
        extirpabilite_par(dossier, fichier)
      else
        parcours("#{fichier}/*")
        next
      end
    end
    if @noms_extirpable_par_dossier.key?(dossier)
      @dossiers_analyses.merge!({ dossier => calcul_taux_d_extirpabilite_par(dossier) })
    end
  end

  def calcul_taux_d_extirpabilite_par(nom_dossier)
    noms_extirpable = @noms_extirpable_par_dossier.fetch(nom_dossier)
    noms_extirpable_possible = @noms_extirpable_par_dossier.fetch(nom_dossier).tally
    if noms_extirpable_possible.key?(true)
      ((noms_extirpable_possible[true] * 100) / noms_extirpable.length)
    else
      0
    end
  end

  def extirpabilite_par(path_dossier, nom_fichier)
    if @noms_extirpable_par_dossier.key?(path_dossier)
      @noms_extirpable_par_dossier.merge!({ path_dossier => @noms_extirpable_par_dossier
        .fetch(path_dossier)
        .push(extracteur.extirpabilite(nom_fichier)) })
    else
      @noms_extirpable_par_dossier.merge!({ path_dossier => [].push(extracteur.extirpabilite(nom_fichier)) })
    end
  end
end
