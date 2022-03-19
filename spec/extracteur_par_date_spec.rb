# frozen_string_literal: true

require "extracteur_par_date"

RSpec.describe ExtracteurParDate do
  describe "doit pouvoir definir quand" do
    where(:case_name, :nom, :attendu) do
      [
        ["le nom 'IMG_20180416_220126'", "IMG_20180416_220126", DateTime.new(2018, 4, 16, 22, 1, 26)],
        ["le nom 'IMG_20180719_205840_01'", "IMG_20180719_205840_01", DateTime.new(2018, 7, 19, 20, 58, 40)],
        ["le nom 'IMG_18122021_1508-03'", "IMG_18122021_1508-03", DateTime.new(2021, 12, 18, 15, 8, 0)],
        ["le nom 'IMG_18122021_1508'", "IMG_18122021_1508", DateTime.new(2021, 12, 18, 15, 8, 0)],
        ["le nom 'IMG_20210803175810'", "IMG_20210803175810", DateTime.new(2021, 8, 3, 17, 58, 10)],
        ["le nom 'IMG_20210612102118-02'", "IMG_20210612102118-02", DateTime.new(2021, 6, 12, 10, 21, 18)],
        ["le nom 'IMG_20190525_080431-modifié'", "IMG_20190525_080431-modifié", DateTime.new(2019, 5, 25, 8, 4, 31)],
        ["le nom 'IMG_20190525_131228_BURST001_COVER'", "IMG_20190525_131228_BURST001_COVER",
         DateTime.new(2019, 5, 25, 13, 12, 28)],
        ["le nom 'IMG_20190525_131228_BURST002'", "IMG_20190525_131228_BURST002",
         DateTime.new(2019, 5, 25, 13, 12, 28)],
        ["le nom '20151231_155723_011'", "20151231_155723_011", DateTime.new(2015, 12, 31, 15, 57, 23)],
        ["le nom '20151231_155747'", "20151231_155747", DateTime.new(2015, 12, 31, 15, 57, 47)],
        ["le nom '2016-08-08 19.28.33'", "2016-08-08 19.28.33", DateTime.new(2016, 8, 8, 19, 28, 33)],
        ["le nom '2013-07-28 09.58.16'", "2013-07-28 09.58.16", DateTime.new(2013, 7, 28, 9, 58, 16)],
        ["le nom '2013-08-05 11.48.35(1)'", "2013-08-05 11.48.35(1)", DateTime.new(2013, 8, 5, 11, 48, 35)],
        ["le nom '2013-10-01 23.50.11-1'", "2013-10-01 23.50.11-1", DateTime.new(2013, 10, 1, 23, 50, 11)],
        ["le nom '2013-12-23 11.29.46 (2)'", "2013-12-23 11.29.46 (2)", DateTime.new(2013, 12, 23, 11, 29, 46)],
        ["le nom '05-11-2010 21-26-00'", "05-11-2010 21-26-00", DateTime.new(2010, 11, 5, 21, 26, 0)],
        ["le nom 'VID_20191006_133847'", "VID_20191006_133847", DateTime.new(2019, 10, 6, 13, 38, 47)],
        ["le nom 'Resized_20190915_132232_23821'", "Resized_20190915_132232_23821",
         DateTime.new(2019, 9, 15, 13, 22, 32)],
        ["le nom '20151231_170821_001 (1)'", "20151231_170821_001 (1)", DateTime.new(2015, 12, 31, 17, 8, 21)],
        ["le nom 'IMG_20210808203548-02'", "IMG_20210808203548-02", DateTime.new(2021, 8, 8, 20, 35, 48)],
        ["le nom '20170713_162541(1)'", "20170713_162541(1)", DateTime.new(2017, 7, 13, 16, 25, 41)],
        ["le nom '20151231_162026 (1)'", "20151231_162026 (1)", DateTime.new(2015, 12, 31, 16, 20, 26)],
        ["le nom 'IMG_20180717_154633_1'", "IMG_20180717_154633_1", DateTime.new(2018, 7, 17, 15, 46, 33)],
        ["le nom 'IMG_20190527_144358~2-modifié'", "2IMG_20190527_144358~2-modifié",
         DateTime.new(2019, 5, 27, 14, 43, 58)],
        ["le nom 'IMG_20190527_144358~2'", "IMG_20190527_144358~2", DateTime.new(2019, 5, 27, 14, 43, 58)],
        ["le nom 'IMG_20190527_150854_1-modifié'", "IMG_20190527_150854_1-modifié",
         DateTime.new(2019, 5, 27, 15, 8, 54)],
        ["le nom 'PANO_20191008_151214'", "PANO_20191008_151214", DateTime.new(2019, 10, 8, 15, 12, 14)],
        ["le nom 'IMG_20200712_115451 (2)'", "IMG_20200712_115451 (2)", DateTime.new(2020, 7, 12, 11, 54, 51)],
        ["le nom 'Photo-2022-01-25-17-11-49_0031'", "Photo-2022-01-25-17-11-49_0031",
         DateTime.new(2022, 1, 25, 17, 11, 49)],
        ["le nom 'PHOTO-2021-09-19-10-08-03 (3)'", "PHOTO-2021-09-19-10-08-03 (3)",
         DateTime.new(2021, 9, 19, 10, 8, 3)],
        ["le nom 'PHOTO-2021-09-19-10-08-06'", "PHOTO-2021-09-19-10-08-06", DateTime.new(2021, 9, 19, 10, 8, 6)],
        ["le nom 'PHOTO-2021-09-19-10-08-06'", "PHOTO-2021-09-19-10-08-06", DateTime.new(2021, 9, 19, 10, 8, 6)],
        ["le nom 'photo_2019_03_05-18_34_59'", "photo_2019_03_05-18_34_59", DateTime.new(2019, 3, 5, 18, 34, 59)],
        ["le nom 'photo_2019_03_05-18_54_59-01'", "photo_2019_03_05-18_54_59-01", DateTime.new(2019, 3, 5, 18, 54, 59)]
      ]
    end
    with_them do
      it "contient une date extirpable" do
        expect(ExtracteurParDate.new.extraction_du(nom)).to eq attendu
      end
    end
  end

  describe "doit déclencher une erreur d'analyse quand" do
    where(:case_name, :nom) do
      [
        ["le nom 'P1000153'", "P1000153"],
        ["le nom 'IMG_0012'", "IMG_0012"],
        ["le nom 'Mes Photos0001'", "Mes Photos0001"],
        ["le nom 'photo famille0050'", "photo famille0050."],
        ["le nom '53400010'", "53400010"],
        ["le nom 'paris 2012 049(1)'", "paris 2012 049(1)"],
        ["le nom '_MG_6616 bis'", "_MG_6616 bis"],
        ["le nom 'Crabe royal. et fine rosace de boudin, verrine '", "Crabe royal. et fine rosace de boudin, verrine "]
      ]
    end
    with_them do
      it "ne contient pas une date" do
        expect do
          ExtracteurParDate.new.extraction_du(nom)
        end.to raise_error(ExtractionErreur, "Aucune date ne peux être extraite sur '#{nom}'")
      end
    end
  end

  describe "doit définir si" do
    where(:case_name, :nom, :attendu) do
      [
        ["le nom 'P1000153'", "P1000153", false],
        ["le nom 'PHOTO-2021-09-19-10-08-06'", "PHOTO-2021-09-19-10-08-06", true],
        ["le nom 'IMG_0012'", "IMG_0012", false],
        ["le nom 'PHOTO-2021-09-19-10-08-06'", "PHOTO-2021-09-19-10-08-06", true],
        ["le nom 'Mes Photos0001'", "Mes Photos0001", false],
        ["le nom 'photo_2019_03_05-18_34_59'", "photo_2019_03_05-18_34_59", true],
        ["le nom 'photo_2019_03_05-18_54_59-01'", "photo_2019_03_05-18_54_59-01", true]
      ]
    end
    with_them do
      it "contient une date" do
        expect(ExtracteurParDate.new.extirpabilite(nom)).to eq attendu
      end
    end
  end
end
