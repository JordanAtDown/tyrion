# frozen_string_literal: true

require "catalogage/etape/verificateur"
require "catalogage/etape/fichier"

RSpec.describe Catalogage::Etape::Verificateur do
  describe "doit pouvoir verifier" do
    before do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}rspec_analyse/vault"
    end

    where(:case_name, :fichiers, :fichiers_analyses, :attendus) do
      [
        [ "le dossier vault",
          { "2021/01/JPG" => ["photo_2021_01_10-15_10_52.jpeg"],
           "2021/01/MP4" => ["video_2022_02_10-11_50_40.mp4"]
          },
          {
            "2021/01/JPG" => [Catalogage::Etape::Fichier.new("camera/img_0051.jpg", ".jpeg", DateTime.new(2021, 1, 10, 15, 10, 52), false, "photo_2021_01_10-15_10_52")],
            "2022/02/MP4" => [Catalogage::Etape::Fichier.new("camera/video/vid_0050.mp4", ".mp4", DateTime.new(2022, 2, 22, 10, 52, 42), false, "video_2022_02_22-10_52_42")]
          },
          {
            "#{FileHelpers::TMP}rspec_analyse/vault/2021/01/JPG/photo_2021_01_10-15_10_52.jpeg" => true,
          }
        ]
      ]
    end
    with_them do
      it do
        FileHelpers.build_fichiers(fichiers, "#{@dossier_tmp[0]}/")
        verificateur = Catalogage::Etape::Verificateur.new

        verificateur.index(fichiers_analyses, "#{FileHelpers::TMP}rspec_analyse/vault")

        expect(verificateur.conflit).to eql attendus
      end

      after do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end
end
