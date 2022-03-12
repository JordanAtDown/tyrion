# frozen_string_literal: true

require "parcours"
require "fileutils"

RSpec.describe Parcours do
  describe "doit définir si" do
    where(:case_name, :fichiers) do
      [
        ["le nom 'P1000153'", ["/annee/mois" => ["01.txt", "IMG_20210803175810.txt", "03.txt"]]]
      ]
    end
    with_them do
      it "contient une date" do
        dossier_tmp = FileUtils.makedirs "/tmp/test01"
        # fichiers.each_pair do |key, value|
        #   chemin_dossier = "#{dossier_tmp}#{key}"
        #   dossier_cree = FileUtils.makedirs(chemin_dossier)

        #   value.each do |fichier|
        #     chemin_fichier = "#{dossier_cree[0]}/#{fichier}"
        #     File.new(chemin_fichier, "a")
        #   end
        # end

        # ParcoursDossier.new.parcours("/tmp/test01/*")

        FileUtils.rmtree(dossier_tmp)
      end
    end
  end
end
