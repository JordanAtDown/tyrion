# frozen_string_literal: true

require "mini_exiftool"

# Exif helpers
module ExifHelpers
  def self.get_datetime(fichier)
    date_time_original = MiniExiftool.new(fichier).date_time_original
    DateTime.parse(date_time_original.to_s) unless MiniExiftool.new(fichier).date_time_original.nil?
  end
end
