# frozen_string_literal: true

require "catalogage/etape/nom_attribuer"
require "catalogage/etape/fichier"

RSpec.describe Catalogage::Etape::NomAttribuer do
  describe "doit pouvoir attribuer un nom" do
    it "de tout les fichiers se trouvant dans un même dossier" do
      date_extraite = DateTime.new(2021, 1, 10, 12, 52, 13)
      fichiers_analyses = {"2021/01/JPG" => [Catalogage::Etape::Fichier.new("/tmp/camera/img.jpeg", ".jpeg", date_extraite, false)]}
      nom_attributeur = Catalogage::Etape::NomAttribuer.new

      nom_attributeur.attribut(fichiers_analyses)

      expect(fichiers_analyses.fetch("2021/01/JPG")).to match_array([
        have_attributes(
          path: "/tmp/camera/img.jpeg",
          extension: ".jpeg",
          date_extraite: date_extraite,
          exif: false,
          type: "photo",
          nom_attribue: "photo_2021_01_10-12_52_13"
        ),
      ])
    end
  end
end
