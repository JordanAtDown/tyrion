# frozen_string_literal: true

require "etape/analyse_etape"
require "extracteur_par_date"

RSpec.describe AnalyseEtape do
  describe "doit pouvoir parcourir" do
    before do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}test01"
    end

    where(:case_name, :fichiers, :attendu) do
      [
        ["le dossier '/annee/mois'", { "/annee/mois" => ["01.ini"] },
         {}],
        ["le dossier '/annee/mois'", { "/annee/mois" => ["01.jpg", "IMG_20210803175810.jpg", "03.jpg"] },
         { "/tmp/test01/annee/mois" => 33 }],
        ["les dossiers de l'année 2012", { "/2012/01" => ["01.png", "IMG_20210803175810.png", "03.png"],
                                           "/2012/02" => ["20151231_155747.png", "IMG_20210803175810.jpeg",
                                                          "05-11-2010 21-26-00.png"] }, { "/tmp/test01/2012/01" => 33,
                                                                                          "/tmp/test01/2012/02" => 100 }]                                                          
      ]
    end
    with_them do
      it "pour en definir le taux d'extirpabilite" do
        FileHelpers.build_fichiers(fichiers, @dossier_tmp[0])

        analyse_etape = AnalyseEtape.new(ExtracteurParDate.new)
        analyse_etape.parcours("#{@dossier_tmp[0]}")

        expect(analyse_etape.dossiers_analyses).to eq attendu
      end

      after do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end

  describe "doit calculer" do
    where(:case_name, :noms_extirpable_par_dossier, :dossier, :attendu) do
      [
        ["de la liste [true, true, true, true]", { "/tmp/vault/2022/02" => [true, true, true, true] },
         "/tmp/vault/2022/02", 100],
        ["de la liste [true, false, true, true]", { "/tmp/vault/2020/01" => [true, false, true, true] },
         "/tmp/vault/2020/01", 75],
        ["de la liste [true, true, false, false]", { "/tmp/vault/2021/02" => [true, true, false, false] },
         "/tmp/vault/2021/02", 50],
        ["de la liste [false, false, false, false]", { "/tmp/vault/2022/12" => [false, false, false, false] },
         "/tmp/vault/2022/12", 0]
      ]
    end
    with_them do
      it "le taux d'extirpabilite" do
        expect(AnalyseEtape.new(ExtracteurParDate.new,
                                noms_extirpable_par_dossier).calcul_taux_d_extirpabilite_par(dossier)).to eq attendu
      end
    end
  end

  describe "doit pouvoir ajouter" do
    where(:case_name, :noms_extirpable_par_dossier, :dossier, :fichier, :attendu) do
      [
        ["un fichier analyse au dossier '/tmp/vault/2022/02'", { "/tmp/vault/2022/02" => [true] },
         "/tmp/vault/2022/02", "IMG_20190525_131228_BURST002", { "/tmp/vault/2022/02" => [true, true] }],
        ["un nouveau dossier '/tmp/vault/2022/02'", {}, "/tmp/vault/2022/02", "Mes Photos0001",
         { "/tmp/vault/2022/02" => [false] }]
      ]
    end
    with_them do
      it "afin de verifier tout tous les fichiers" do
        expect(AnalyseEtape.new(ExtracteurParDate.new, noms_extirpable_par_dossier).extirpabilite_par(dossier,
                                                                                                      fichier)).to eq attendu
      end
    end
  end
end
