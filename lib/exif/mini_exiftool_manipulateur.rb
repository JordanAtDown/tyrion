# frozen_string_literal: true

require "mini_exiftool"

# MiniExiftool manipulateur
module MiniExifToolManipulateur
  # Exif Manipulateur erreur
  class ExifManipulateurErreur < StandardError; end
  # Exif Manipulateur
  class ExifManipulateur
    def set_datetimeoriginal(fichier, datetimeoriginal)
      begin
        image = MiniExiftool.new(fichier)
        image.datetimeoriginal = datetimeoriginal
        image.save
        image
      rescue MiniExiftool::Error => e
        raise ExifManipulateurErreur, e
      end
    end
  end
end
