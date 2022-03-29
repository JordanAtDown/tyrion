# frozen_string_literal: true

require "mini_exiftool"

require "images/exif/exif_manipulateur"

# Exif Manipulateur
class MiniExiftoolManipulateur
  include ExifManipulateur
  def set_datetimeoriginal(fichier, datetimeoriginal)
    exif = MiniExiftool.new(fichier)
    exif.datetimeoriginal = datetimeoriginal
    exif.save
    exif
  rescue MiniExiftool::Error => e
    raise ExifManipulateur::ExifManipulateurErreur, e
  end

  def datetimeoriginal?(fichier)
    !MiniExiftool.new(fichier).datetimeoriginal.nil?
  rescue MiniExiftool::Error => e
    raise ExifManipulateur::ExifManipulateurErreur, e
  end

  def get_datetimeoriginal(fichier)
    DateTime.parse(MiniExiftool.new(fichier).datetimeoriginal.to_s)
  rescue MiniExiftool::Error => e
    raise ExifManipulateur::ExifManipulateurErreur, e
  end
end
