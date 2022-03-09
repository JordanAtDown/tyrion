# frozen_string_literal: true

require "renommeur"

RSpec.describe Renommeur do
  describe "doit pouvoir attribuer" do
    where(:case_name, :nom, :noms_attribues, :attendu) do
      [
        ["le nom 'photo_2023_02_01-12_50_12'", "photo_2023_02_01-12_50_12", [], "photo_2023_02_01-12_50_12"],
        ["le nom 'photo_2023_02_01-12_50_12-01'", "photo_2023_02_01-12_50_12", ["photo_2023_02_01-12_50_12"],
         "photo_2023_02_01-12_50_12-01"],
        ["le nom 'photo_2023_02_01-12_50_12-02'", "photo_2023_02_01-12_50_12",
         %w[photo_2023_02_01-12_50_12 photo_2023_02_01-12_50_12-01], "photo_2023_02_01-12_50_12-02"]
      ]
    end
    with_them do
      it "afin d'éviter les doublons" do
        renommeur = Renommeur.new(noms_attribues)
        expect(renommeur.numerotation(nom)).to eq attendu
      end
    end
  end
end
