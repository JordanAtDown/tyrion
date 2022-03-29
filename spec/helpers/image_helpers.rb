# frozen_string_literal: true

require "base64"

module ImageHelpers
  RESSOURCES = File.expand_path("../resources", __dir__)

  def self.creer_(path, nom, type, extension = "jpeg")
    base64_data = File.open("#{RESSOURCES}/#{type}").read
    fichier = "#{path}/#{nom}.#{extension}"
    File.open(fichier, "wb") do |f|
      f.write(Base64.decode64(base64_data))
    end
    fichier
  end
end
