# frozen_string_literal: true

require "mini_exiftool"

require "etape/exif_manipulateur"

# Exif Manipulateur
class MiniExiftoolManipulateur
  include ExifManipulateur
  def set_datetimeoriginal(fichier, datetimeoriginal)
    begin
      image = MiniExiftool.new(fichier)
      image.datetimeoriginal = datetimeoriginal
      image.save
      image
    rescue MiniExiftool::Error => e
      raise ExifManipulateur::ExifManipulateurErreur, e
    end
  end
end
