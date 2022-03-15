# frozen_string_literal: true

require "etape/fichier"

RSpec.describe Fichier do
  describe "doit pouvoir ajouter" do
    where(:case_name, :fichier, :attendu) do
      [
        ["nom", Fichier.new("photo_2021_01_01-10_05_55", DateTime.new(2021, 1, 1, 10, 5, 55), "/tmp/vault/2021/01", ".jpg"), "/tmp/vault/2021/01/photo_2021_01_01-10_05_55.jpg"],
        ["nom2", Fichier.new("photo_2021_01_01-10_05_55", DateTime.new(2021, 1, 1, 10, 5, 55), "/tmp/vault/2021/01", ".JPEG"), "/tmp/vault/2021/01/photo_2021_01_01-10_05_55.jpeg"]
      ]
    end
    with_them do
      it "afin de verifier tout tous les fichiers" do
        expect(fichier.get_nouveau_nom).to eq attendu
      end
    end
  end

  describe "doit pouvoir ajouter" do
    where(:case_name, :fichier, :attendu) do
      [
        ["nom", Fichier.new("photo_2021_01_01-10_05_55", DateTime.new(2021, 1, 1, 10, 5, 55), "/tmp/vault/2021/01", ".jpg"), "/tmp/vault/2021/01/JPG/photo_2021_01_01-10_05_55.jpg"],
        ["nom2", Fichier.new("photo_2021_01_01-10_05_55", DateTime.new(2021, 1, 1, 10, 5, 55), "/tmp/vault/2021/01", ".JPEG"), "/tmp/vault/2021/01/JPG/photo_2021_01_01-10_05_55.jpeg"]
      ]
    end
    with_them do
      it "afin de verifier tout tous les fichiers" do
        expect(fichier.get_path_nouveau_chemin).to eq attendu
      end
    end
  end
end
