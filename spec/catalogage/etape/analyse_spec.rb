# frozen_string_literal: true

require "catalogage/etape/analyse"
require "catalogage/etape/fichier"

RSpec.describe Catalogage::Etape::Analyse do
  describe "doit pouvoir analyser" do
    before do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}rspec_analyse"
    end

    where(:case_name, :fichiers, :attendus) do
      [
        [ "le dossier 'camera'",
          { "camera/video" => ["test.mp4"],
           "camera" => ["img.jpg"]
          },
          {
            "2021/01/MP4" => nil,
            "none/JPG" => nil
          }
        ]
      ]
    end
    with_them do
      it do
        FileHelpers.build_fichiers(fichiers, "#{@dossier_tmp[0]}/")
        extracteur_mock = mock
        exif_manipulateur = mock
        exif_manipulateur.stubs(:datetimeoriginal?).with("#{FileHelpers::TMP}rspec_analyse/camera/video/test.mp4").then.returns(true)
        exif_manipulateur.stubs(:get_datetimeoriginal).with("#{FileHelpers::TMP}rspec_analyse/camera/video/test.mp4").then.returns(DateTime.new(2021, 1, 10, 12, 25, 52))
        exif_manipulateur.stubs(:datetimeoriginal?).with("#{FileHelpers::TMP}rspec_analyse/camera/img.jpg").then.returns(false)
        extracteur_mock.stubs(:extirpabilite).with("#{FileHelpers::TMP}rspec_analyse/camera/img.jpg").then.returns(false)
        analyse = Catalogage::Etape::Analyse.new(extracteur_mock, exif_manipulateur)

        analyse.analyser("#{FileHelpers::TMP}rspec_analyse/camera")
        fichiers_analyses = analyse.fichiers_analyses

        attendus.each_pair do |key, _value|
          expect(fichiers_analyses.key?(key)).to be_truthy
        end
      end

      after do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end
end