# frozen_string_literal: true

module DossierParExtension
  def self.defini_dossier_par(extension)
    if extension.downcase == ".jpeg"
      "JPG"
    else
      extension[/[a-zA-Z0-9]+/].upcase
    end
  end
end
