# frozen_string_literal: true

# Converti une extension
module DossierParExtension
  def self.defini_dossier_par(extension)
    if extension.downcase == ".jpeg"
      "JPG"
    else
      extension[/[a-zA-Z0-9]+/].upcase
    end
  end
end
