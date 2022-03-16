# frozen_string_literal: true

require "base64"

module ImageHelpers
  RESSOURCES = File.expand_path("../../resources/", __FILE__)

  IMAGE = "image.b64"

  def self.creer_(path, nom, type)
    base64_data = File.open("#{RESSOURCES}/#{type}").read
    extension = "jpeg"
    fichier = "#{path}/#{nom}.#{extension}"
    File.open(fichier, "wb") do |f|
      f.write(Base64.decode64(base64_data))
    end
    fichier
  end

  def self.generer_(path, type)
    encode = Base64.encode64(File.open(path).read)
    fichier = "#{RESSOURCES}/#{type}"
    File.open(fichier, "wb") do |f|
      f.write(encode.gsub(/\n/, ""))
    end
  end
end
