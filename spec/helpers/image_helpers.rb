# frozen_string_literal: true

require "base64"
require "mime/types"

module ImageHelpers
  RESSOURCES = File.expand_path("../../resources/", __FILE__)

  def self.creer_(path, nom)
    read_data = File.open("#{RESSOURCES}/arbre.b64")
    base64_data = read_data.read
    regex_mime_type = /\Adata:([-\w]+\/[-\w\+\.]+)?;base64,(.*)/
    data_uri_parts = base64_data.match(regex_mime_type) || []
    extension = MIME::Types[data_uri_parts[1]].first.preferred_extension
    fichier = "#{path}/#{nom}.#{extension}"
    File.open(fichier, "wb") do |f|
      f.write(Base64.decode64(base64_data))
    end
  end
end
