# frozen_string_literal: true

require "observer"

require "notification/analyse_notification"

# Definit l'étape d'analyse
class AnalyseEtape
  include Observable

  attr_accessor :dossiers_analyses
  attr_reader :noms_extirpable_par_dossier, :extracteur

  def initialize(extracteur, noms_extirpable_par_dossier = {}, dossiers_analyses = {})
    @extracteur = extracteur
    @noms_extirpable_par_dossier = noms_extirpable_par_dossier
    @dossiers_analyses = dossiers_analyses
  end

  def parcours(path_dossier)
    dossier = File.dirname(path_dossier)
    Dir.glob(path_dossier) do |fichier|
      if File.file?(fichier)
        extirpabilite_par(dossier, fichier)
      else
        parcours("#{fichier}/*")
        next
      end
    end
    if @noms_extirpable_par_dossier.key?(dossier)
      taux = calcul_taux_d_extirpabilite_par(dossier)
      @dossiers_analyses.merge!({ dossier => taux })
      changed
      notify_observers(Time.now, AnalyseNotification.new(dossier, taux))
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
