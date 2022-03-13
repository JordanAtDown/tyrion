# frozen_string_literal: true

require "etape/renommageEtape"
require "analyseur"

RSpec.describe RenommageEtape do
  describe "doit pouvoir parcourir" do
    where(:case_name, :fichiers, :attendu) do
      [
        ["le dossier '/2012/01'", { "/2012/01" => ["IMG_20210803175810.jpg"] }, { "/tmp/test01/2021/08/IMG_20210803175810.jpg" => Fichier.new("photo_2021_08_03-17_58_10") }]
      ]
    end
    with_them do
    it "pour en definir le taux d'analyse" do
      dossier_tmp = FileUtils.makedirs "/tmp/test02"

      fichiers.each_pair do |key, value|
        chemin_dossier = "#{dossier_tmp[0]}#{key}"
        dossier_cree = FileUtils.makedirs(chemin_dossier)

        value.each do |fichier|
          chemin_fichier = "#{dossier_cree[0]}/#{fichier}"
          File.new(chemin_fichier, "a")
        end
      end

      renommage_etape = RenommageEtape.new(Analyseur.new)
      renommage_etape.parcours("#{dossier_tmp[0]}/*")
      expect(renommage_etape.fichiers).to eq attendu

      FileUtils.rmtree(dossier_tmp)
    end
    end
  end
end
