# frozen_string_literal: true

# Application notification
class ApplicationNotification
  attr_reader :nom_fichier

  def initialize(nom_fichier)
    @nom_fichier = nom_fichier
  end
end
