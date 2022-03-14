# frozen_string_literal: true

require "etape/traitement_dossier_non_extirpable"
require "etape/fichier"

RSpec.describe TraitementDossierNonExtirpableEtape do
  describe "doit pouvoir parcourir" do
    
    before(:example) do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}test01"
    end

    where(:case_name, :fichiers, :attendu) do
      [
        ["le dossier '/2012/01'", { "/2012/01" => ["P1000153.jpg"] }, { "/tmp/test02/2012/01/P1000153.jpg" => Fichier.new("001", DateTime.new(2021, 9, 19, 10, 8, 6), "/tmp/test02/2012/01/P1000153.jpg", ".jpg") }]
      ]
    end
    with_them do
      it "pour en definir les fichiers à traités" do
        FileHelpers.build_fichier(fichiers, @dossier_tmp[0])

        traitement_etape = TraitementDossierNonExtirpableEtape.new
        traitement_etape.parcours("#{@dossier_tmp[0]}/*")

        expect(traitement_etape.fichiers).to eq attendu
        FileUtils.rmtree(dossier_tmp)
      end

      after(:example) do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end
end
