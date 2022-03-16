# frozen_string_literal: true

require "exif/mini_exiftool_manipulateur"

RSpec.describe MiniExifToolManipulateur do
  describe "doit modifier" do
    before do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}test01"
    end

    where(:case_name, :nom_fichier, :date_time_original) do
      [
        ["la date time original '2020/02/01 01h01m01s'", "photo_2020_02_01-01-01-01", DateTime.new(2020, 2, 1, 1, 1, 1)]
      ]
    end
    with_them do
      it "pour une image" do
        image = ImageHelpers.creer_("#{FileHelpers::TMP}test01", nom_fichier, ImageHelpers::IMAGE)
        
        MiniExifToolManipulateur::ExifManipulateur.new.set_datetimeoriginal(image, date_time_original)

        expect(ExifHelpers.get_datetime(image)).to eql date_time_original.strftime("%Y:%m:%d %H:%M:%S")
      end

      after do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end
end
