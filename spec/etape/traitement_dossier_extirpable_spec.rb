# frozen_string_literal: true

require "etape/traitement_dossier_extirpable"
require "etape/fichier"
require "extracteur_par_date"

require "rspec/expectations"

RSpec.describe TraitementDossierExtirpableEtape do
  describe "doit pouvoir parcourir" do
    
    before(:example) do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}test01"
    end

    where(:case_name, :fichiers, :attendu) do
      [
        ["le dossier '/2012/01'", { "/2012/01" => ["IMG_20210803175810.jpg"] }, { "/tmp/test01/2021/08/IMG_20210803175810.jpg" => Fichier.new("photo_2021_08_03-17_58_10", DateTime.new(2021, 8, 3, 17, 58, 10), "/tmp/test01/2021/08/IMG_20210803175810.jpg", ".jpg") }],
      ]
    end
    with_them do
      it "pour en definir les fichiers à traités" do
        FileHelpers.build_fichier(fichiers, @dossier_tmp[0])

        traitement_etape = TraitementDossierExtirpableEtape.new(ExtracteurParDate.new)
        traitement_etape.parcours("#{@dossier_tmp[0]}/*")
        
        expect(traitement_etape.fichiers).to eql? attendu
      end

      after(:example) do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end
end
