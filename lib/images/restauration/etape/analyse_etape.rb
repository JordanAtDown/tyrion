# frozen_string_literal: true

require "logging"

# Definit l'étape d'analyse
class AnalyseEtape
  attr_reader :dossiers_analyses, :nombre_fichiers_analyses

  EXTENSIONS_EXCLUS = /\.(?!(ini|log|1|db-shm|db-wal|db)$)([^.]+$)/.freeze

  def initialize(extracteur, noms_extirpable_par_dossier = {}, dossiers_analyses = {})
    @extracteur = extracteur
    @noms_extirpable_par_dossier = noms_extirpable_par_dossier
    @dossiers_analyses = dossiers_analyses
    @log = Logging.logger[self]
    @nombre_fichiers_analyses = 0
  end

  def parcours(dossier)
    @log.debug "Parcours du dossier '#{dossier}'"
    Dir.each_child(dossier) do |nom_fichier|
      fichier = "#{dossier}/#{nom_fichier}"
      if File.file?(fichier)
        if File.extname(fichier) =~ EXTENSIONS_EXCLUS
          extirpabilite_par(dossier, fichier)
          @nombre_fichiers_analyses += 1
        else
          @log.warn "Le fichier '#{fichier}' ne sera pas analysé"
        end
      else
        parcours(fichier)
        next
      end
    end
    if @noms_extirpable_par_dossier.key?(dossier)
      taux = calcul_taux_d_extirpabilite_par(dossier)
      @dossiers_analyses.store(dossier, taux)
      @log.info "Le dossier '#{dossier}' posséde un taux de #{taux}% d'extirpabilité"
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
    extirpable = @extracteur.extirpabilite(nom_fichier)
    nom_extirpable_par_dossier = if @noms_extirpable_par_dossier.key?(path_dossier)
                                   @noms_extirpable_par_dossier.merge!({ path_dossier => @noms_extirpable_par_dossier
                                     .fetch(path_dossier)
                                     .push(extirpable) })
                                 else
                                   @noms_extirpable_par_dossier.merge!({ path_dossier => [].push(extirpable) })
                                 end
    @log.debug "Le fichier '#{nom_fichier}' est extirpable : #{extirpable}"
    nom_extirpable_par_dossier
  end
end
