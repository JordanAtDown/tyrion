# frozen_string_literal: true

require "mini_exiftool"

# MiniExiftool manipulateur
module MiniExifToolManipulateur
  # Exif Manipulateur
  class ExifManipulateur
    def set_datetimeoriginal(fichier, datetimeoriginal)
      image = MiniExiftool.new(fichier)
      image.datetimeoriginal = datetimeoriginal
      image.save
      image
    end
  end
end
