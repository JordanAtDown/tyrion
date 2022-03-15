# frozen_string_literal: true

# Directory
module Directory
  # '/mnt/d/backup/test/Vault/2021/12/IMG_18122021_1531-01.jpg'
  def self.get_date(nom_dossier)
    chemins_dossier = nom_dossier.split("/")
    annee = chemins_dossier.select { |v| v =~ /^([0-9]{4})$/ }
    mois = chemins_dossier.select { |v| v =~ /^([0-9]{2})$/ }
    DateTime.new(annee[0].to_i, mois[0].to_i, 1, 0, 0, 0)
  end
end
