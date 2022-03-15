# frozen_string_literal: true

# Traitement notification
class TraitementNotification
  attr_reader :nom_fichier

  def initialize(nom_fichier)
    @nom_fichier = nom_fichier
  end
end
