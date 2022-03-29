# frozen_string_literal: true

require "etape/analyse_etape"

RSpec.describe AnalyseEtape do
  describe "doit pouvoir parcourir" do
    before do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}test01"
    end

    where(:case_name, :fichiers, :attendu, :stubs_return, :nombres_fichiers_analyses) do
      [
        ["le dossier '/annee/mois'",
         { "/annee/mois" => ["01.ini", "owncloud.log", ".owncloudsync.log", ".owncloudsync.log.1", ".sync_journal.db",
                             ".sync_journal.db-shm", ".sync_journal.db-wal"] },
         {},
         {},
         0],
        ["le dossier '/annee/mois'",
         { "/annee/mois" => ["01.jpg", "IMG_20210803175810.jpg", "03.jpg"] },
         { "/tmp/test01/annee/mois" => 33 },
         { "/tmp/test01/annee/mois/01.jpg" => false,
           "/tmp/test01/annee/mois/IMG_20210803175810.jpg" => true,
           "/tmp/test01/annee/mois/03.jpg" => false },
         3]
      ]
    end
    with_them do
      it "pour en definir le taux d'extirpabilite" do
        dossier_a_parcourir = @dossier_tmp[0]
        FileHelpers.build_fichiers(fichiers, dossier_a_parcourir)
        extracteur_mock = mock
        stubs_return.each_pair do |key, value|
          extracteur_mock.stubs(:extirpabilite).with(key).then.returns(value)
        end

        analyse_etape = AnalyseEtape.new(extracteur_mock)
        analyse_etape.parcours(dossier_a_parcourir)

        expect(analyse_etape.dossiers_analyses).to eq attendu
        expect(analyse_etape.nombre_fichiers_analyses).to eq nombres_fichiers_analyses
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
        extracteur_mock = mock
        extracteur_mock.expects(:extirpabilite).never

        expect(AnalyseEtape.new(extracteur_mock,
                                noms_extirpable_par_dossier).calcul_taux_d_extirpabilite_par(dossier)).to eq attendu
      end
    end
  end

  describe "doit pouvoir ajouter" do
    where(:case_name, :noms_extirpable_par_dossier, :dossier, :fichier, :attendu, :stubs_return) do
      [
        ["un fichier analyse au dossier '/tmp/vault/2022/02'",
         { "/tmp/vault/2022/02" => [true] },
         "/tmp/vault/2022/02",
         "IMG_20190525_131228_BURST002",
         { "/tmp/vault/2022/02" => [true, true] },
         true],
        ["un nouveau dossier '/tmp/vault/2022/02'",
         {},
         "/tmp/vault/2022/02",
         "Mes Photos0001",
         { "/tmp/vault/2022/02" => [false] },
         false]
      ]
    end
    with_them do
      it do
        extracteur_mock = mock
        extracteur_mock.stubs(:extirpabilite).with(fichier).returns(stubs_return)

        extirpable = AnalyseEtape.new(extracteur_mock, noms_extirpable_par_dossier).extirpabilite_par(dossier, fichier)

        expect(extirpable).to eq attendu
      end
    end
  end
end
