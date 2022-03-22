# frozen_string_literal: true

require "file_type"

# Restauration
class Restauration
  def initialize(analyse, traitement_dossier_extirpable, traitement_dossier_non_extirpable, application, configuration)
    @analyse = analyse
    @traitement_dossier_extirpable = traitement_dossier_extirpable
    @traitement_dossier_non_extirpable = traitement_dossier_non_extirpable
    @application_photos = application
    @configuration = configuration
  end

  def process(dossier)
    @analyse.parcours(dossier)

    dossiers_extirpable = @analyse.dossiers_analyses.select { |_key, value| value == 100 }.keys
    @traitement_dossier_extirpable.parcours(dossiers_extirpable)

    dossiers_non_extirpable = @analyse.dossiers_analyses.select { |_key, value| value < 100 }.keys
    @traitement_dossier_non_extirpable.parcours(dossiers_non_extirpable)

    all_photos = @traitement_dossier_extirpable.get_par_type(FileType::PHOTO).merge(@traitement_dossier_non_extirpable.get_par_type(FileType::PHOTO))
    all_videos = @traitement_dossier_extirpable.get_par_type(FileType::VIDEO).merge(@traitement_dossier_non_extirpable.get_par_type(FileType::VIDEO))
    @application_photos.parcours(all_photos) if @configuration.apply
  end
end
