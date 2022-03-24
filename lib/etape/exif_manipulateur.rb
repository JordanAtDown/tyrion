# frozen_string_literal: true

# Exif Manipulateur
module ExifManipulateur
  # Exif Manipulateur erreur
  class ExifManipulateurErreur < StandardError; end

  def set_datetimeoriginal(_fichier, _datetimeoriginal)
    raise "Non implémenté"
  end

  def datetimeoriginal?(_fichier)
    raise "Non implémenté"
  end

  def get_datetimeoriginal(_fichier)
    raise "Non implémenté"
  end
end
