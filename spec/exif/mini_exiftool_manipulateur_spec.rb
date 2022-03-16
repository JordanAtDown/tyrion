# frozen_string_literal: true

require "exif/mini_exiftool_manipulateur"

RSpec.describe AnalyseEtape do
  describe "doit pouvoir parcourir" do
    before do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}test01"
    end

    where(:case_name) do
      [
        [""]
      ]
    end
    with_them do
      it "pour en definir le taux d'extirpabilite" do
        image = ImageHelpers.creer_("#{FileHelpers::TMP}test01", "photo_2020_02_01-01-01-01")

        # MiniExifToolManipulateur::ExifManipulateur.new.set_datetimeoriginal(image, DateTime.new())
        
        # expect(ExifHelpers.get_datetime(image)).to eql DateTime.new()
      end

      after do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end
end
