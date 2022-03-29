# frozen_string_literal: true

require "images/restauration/etape/traitement_dossier_non_extirpable"
require "images/restauration/fichier"

RSpec.describe Restauration::Etape::TraitementDossierNonExtirpable do
  describe "doit pouvoir parcourir" do
    before do
      @dossier_test = "TraitementDossierNonExtirpableEtape"
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}test01"
    end

    where(:case_name, :dossiers, :fichiers, :attendu) do
      [
        ["le dossier '/2012/01'", ["#{FileHelpers::TMP}test01/2012/01"], { "/2012/01" => ["P1000153.jpg"] },
         { "/tmp/test01/2012/01/P1000153.jpg" => Restauration::Fichier.new("001", DateTime.new(2012, 1, 1, 0, 0, 0), "/tmp/test01/2012/01", ".jpg") }]
      ]
    end
    with_them do
      it "pour en definir les fichiers à traités" do
        FileHelpers.build_fichiers(fichiers, @dossier_tmp[0])

        traitement_etape = Restauration::Etape::TraitementDossierNonExtirpable.new
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
