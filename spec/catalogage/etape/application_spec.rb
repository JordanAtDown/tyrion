# frozen_string_literal: true

require "catalogage/etape/application"
require "catalogage/etape/fichier"

RSpec.describe Catalogage::Etape::Application do
  describe "doit pouvoir analyser" do
    before do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}rspec_analyse"
    end

    where(:case_name, :fichiers, :fichiers_analyses, :destination, :attendu, :fichiers_destination) do
      [
        ["le dossier 'camera'",
         { "camera/video" => ["test.mp4"],
           "camera" => ["img.jpg"] },
         { "2021/10/JPG" => [Catalogage::Etape::Fichier.new("#{FileHelpers::TMP}rspec_analyse/camera/img.jpg", ".jpg", DateTime.new(2021, 10, 24, 10, 52, 13), false, "photo_2021_10_24-10_52_13")],
           "2022/01/MP4" => [Catalogage::Etape::Fichier.new("#{FileHelpers::TMP}rspec_analyse/camera/video/test.mp4",
                                                            ".mp4", DateTime.new(2022, 1, 20, 10, 52, 13), true, "video_2022_01_20-10_52_13")] },
         "#{FileHelpers::TMP}rspec_analyse/destination",
         [
           "#{FileHelpers::TMP}rspec_analyse/destination/2021/10/JPG/photo_2021_10_24-10_52_13.jpg",
           "#{FileHelpers::TMP}rspec_analyse/destination/2022/01/MP4/video_2022_01_20-10_52_13.mp4",
           "#{FileHelpers::TMP}rspec_analyse/destination/2021/10/JPG/photo_2021_10_05-09_55_12.jpg"
         ],
         {
           "2021/10/JPG" => ["photo_2021_10_05-09_55_12.jpg", "photo_2021_10_24-10_52_13.jpg"]
         }]
      ]
    end
    with_them do
      it do
        FileHelpers.build_fichiers(fichiers, "#{@dossier_tmp[0]}/")
        FileUtils.mkdir_p("#{FileHelpers::TMP}rspec_analyse/destination")
        FileHelpers.build_fichiers(fichiers_destination, "#{@dossier_tmp[0]}/destination/")
        exif_manipulateur = mock
        exif_manipulateur.stubs(:set_datetimeoriginal).with("#{FileHelpers::TMP}rspec_analyse/camera/img.jpg",
                                                            DateTime.new(2021, 10, 24, 10, 52, 13))
        application = Catalogage::Etape::Application.new(exif_manipulateur)

        application.applique(fichiers_analyses, destination)

        expect(attendu.size).to eq FileHelpers.nombre_fichiers("#{FileHelpers::TMP}rspec_analyse/destination")
        attendu.each do |fichier|
          expect(File).to exist(fichier)
        end
      end

      after do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end
end
