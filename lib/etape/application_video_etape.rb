# frozen_string_literal: true

require "fileutils"
require "logging"

# Définit l'étape d'application de traitement pour les videos
class ApplicationVideoEtape
  def initialize
    @log = Logging.logger[self]
  end

  def parcours(fichiers); end
end
