# frozen_string_literal: true

module Restauration
  # Restauration
  class Restore
    def initialize(analyse, traitement_dossier_extirpable, traitement_dossier_non_extirpable, application, configuration)
      @analyse = analyse
      @traitement_dossier_extirpable = traitement_dossier_extirpable
      @traitement_dossier_non_extirpable = traitement_dossier_non_extirpable
      @application_photos = application
      @configuration = configuration
      @log = Logging.logger[self]
    end

    def process(dossier)
      @analyse.parcours(dossier)

      dossiers_extirpable = @analyse.dossiers_analyses.select { |_key, value| value == 100 }.keys
      @traitement_dossier_extirpable.parcours(dossiers_extirpable)

      dossiers_non_extirpable = @analyse.dossiers_analyses.select { |_key, value| value < 100 }.keys
      @traitement_dossier_non_extirpable.parcours(dossiers_non_extirpable)

      all_fichiers = @traitement_dossier_extirpable.fichiers.merge(@traitement_dossier_non_extirpable.fichiers)

      @log.info "Nombre de fichiers analysés : #{@analyse.nombre_fichiers_analyses}"
      @log.info "Nombre de fichiers traités : #{all_fichiers.length}"

      if @configuration.apply && all_fichiers.length == @analyse.nombre_fichiers_analyses
        @application_photos.parcours(all_fichiers)
      end
    end
  end
end
