# frozen_string_literal: true

require "rspec/expectations"

require "images/restauration/etape/traitement_dossier_extirpable"
require "images/restauration/fichier"

RSpec.describe Restauration::Etape::TraitementDossierExtirpable do
  describe "doit pouvoir parcourir" do
    before do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}test01"
    end

    where(:case_name, :dossiers, :fichiers, :attendu) do
      [
        ["le dossier '/2012/08'",
         ["#{FileHelpers::TMP}test01/2012/08"],
         { "/2012/08" => ["IMG_20210803175810.jpg"] },
         { "/tmp/test01/2012/08/IMG_20210803175810.jpg" =>
          Restauration::Fichier.new("photo_2021_08_03-17_58_10", DateTime.new(2021, 8, 3, 17, 58, 10), "/tmp/test01/2012/08",
                              ".jpg") }]
      ]
    end
    with_them do
      it "pour en definir les fichiers à traités" do
        FileHelpers.build_fichiers(fichiers, @dossier_tmp[0])
        extracteur_mock = mock
        extracteur_mock.stubs(:extraction_du).with("IMG_20210803175810").then.returns(DateTime.new(2021, 8, 3, 17, 58,
                                                                                                   10))

        traitement_etape = Restauration::Etape::TraitementDossierExtirpable.new(extracteur_mock)
        traitement_etape.parcours(dossiers)

        attendu.each_pair do |key, value|
          expect(traitement_etape.fichiers).to be_key(key)
          expect(traitement_etape.fichiers.fetch(key)).to have_attributes(
            nom_attribue: value.nom_attribue,
            date: value.date,
            path: value.path,
            extension: value.extension
          )
        end
      end

      after do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end
end
