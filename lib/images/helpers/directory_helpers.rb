# frozen_string_literal: true

require "fileutils"
require "date"

# Directory
module DirectoryHelpers
  def self.get_date(nom_dossier)
    chemins_dossier = nom_dossier.split("/")
    annee = chemins_dossier.select { |v| v =~ /^([0-9]{4})$/ }
    mois = chemins_dossier.select { |v| v =~ /^([0-9]{2})$/ }
    DateTime.new(annee[0].to_i, mois[0].to_i, 1, 0, 0, 0)
  end

  def self.cree_le(dossier)
    FileUtils.mkdir_p(dossier) if dossier != "" && !Dir.exist?(dossier)
    dossier
  end

  def self.defini_dossier_par(extension)
    if extension.downcase == ".jpeg"
      "JPG"
    else
      extension[/[a-zA-Z0-9]+/].upcase
    end
  end

  def self.nombre_fichiers(dossier)
    Dir.glob(File.join(dossier, "**", "*")).select { |file| File.file?(file) }.count
  end
end
