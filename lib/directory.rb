# frozen_string_literal: true

# Directory
module Directory
  def self.get_date(nom_dossier)
    chemins_dossier = nom_dossier.split("/")
    DateTime.new(chemins_dossier[3].to_i, chemins_dossier[4].to_i, 1, 0, 0, 0)
  end
end
