# frozen_string_literal: true

require "mini_exiftool"

# Exif helpers
module ExifHelpers
  def self.get_datetime(fichier)
    MiniExiftool.new(fichier).date_time_original
  end
end
