# frozen_string_literal: true

require "configuration"

require "images/catalogage/cataloger"
require "images/catalogage/etape/analyse"
require "images/catalogage/etape/application"
require "images/catalogage/etape/nom_attribuer"
require "images/catalogage/etape/verificateur"

require "extracteur_par_date"
require "exif/mini_exiftool_manipulateur"

RSpec.describe Catalogage::Cataloger do
  describe "doit cataloguer" do
    before do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}rspec_catalog"
    end

    where(:case_name, :fichiers, :attendu) do
      [
        ["le dossier camera",
         { "camera" => ["PHOTO-2021-09-19-10-08-06.png"] },
         [
           ""
         ]]
      ]
    end
    with_them do
      it do
        FileHelpers.build_fichiers(fichiers, @dossier_tmp[0])
        dossier_destination = FileUtils.mkdir_p("#{FileHelpers::TMP}rspec_catalog/destination")
        exif_manipulateur_mock = mock
        extracteur_mock = mock
        configuration = Configuration.new(true, dossier_destination[0])

        Catalogage::Cataloger.new(
          Catalogage::Etape::Analyse.new(extracteur_mock, exif_manipulateur_mock),
          Catalogage::Etape::NomAttribuer.new,
          Catalogage::Etape::Application.new(exif_manipulateur_mock),
          Catalogage::Etape::Verificateur.new
        ).process(@dossier_tmp[0], configuration)
      end

      after do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end
end
