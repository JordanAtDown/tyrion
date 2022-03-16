# frozen_string_literal: true

require "exif"

module ExifHelpers
  def self.get_datetime(fichier)
    Exif::Data.new(File.open(fichier)).date_time
  end
end
