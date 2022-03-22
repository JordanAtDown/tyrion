# frozen_string_literal: true

require "fileutils"
require "date"

# Directory
module Directory
  def self.get_date(nom_dossier)
    chemins_dossier = nom_dossier.split("/")
    annee = chemins_dossier.select { |v| v =~ /^([0-9]{4})$/ }
    mois = chemins_dossier.select { |v| v =~ /^([0-9]{2})$/ }
    DateTime.new(annee[0].to_i, mois[0].to_i, 1, 0, 0, 0)
  end

  def self.cree_le(dossier)
    if dossier != ""
      if !Dir.exist?(dossier)
        FileUtils.mkdir_p(dossier)
      end
    end
    dossier
  end
end
