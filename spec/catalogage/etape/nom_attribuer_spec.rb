# frozen_string_literal: true

require "images/catalogage/etape/nom_attribuer"
require "images/catalogage/etape/fichier"

RSpec.describe Catalogage::Etape::NomAttribuer do
  describe "doit pouvoir attribuer un nom" do
    it "de tout les fichiers se trouvant dans un même dossier" do
      date_extraite = DateTime.new(2021, 1, 10, 12, 52, 13)
      fichiers_analyses = { "2021/01/JPG" => [Catalogage::Etape::Fichier.new("/tmp/camera/img.jpeg", ".jpeg",
                                                                             date_extraite, false)] }
                                                                             
      Catalogage::Etape::NomAttribuer.new.attribut(fichiers_analyses)

      expect(fichiers_analyses.fetch("2021/01/JPG")[0].path).to eql "/tmp/camera/img.jpeg"
      expect(fichiers_analyses.fetch("2021/01/JPG")[0].exif).to be_falsey
      expect(fichiers_analyses.fetch("2021/01/JPG")[0].date_extraite).to eql date_extraite
    end
  end
end
