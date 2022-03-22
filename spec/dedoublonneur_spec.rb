# frozen_string_literal: true

require "dedoublonneur"

RSpec.describe Dedoublonneur do
  describe "doit pouvoir dedoublonner" do
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
      it "en ajoutant une numerotation" do
        dedoublonneur = Dedoublonneur.new(noms_attribues)
        expect(dedoublonneur.dedoublonne_par_numerotation(nom)).to eq attendu
      end
    end
  end

  describe "doit pouvoir dedoublonner" do
    where(:case_name, :noms_attribues_par_extension, :extension, :attendu) do
      [
        ["le numéro '001'", {}, "jpg", "001"],
        ["le numéro '003'", { "photo" => ["001", "002"] }, "jpg", "003"],
        ["le numéro '002'", { "photo" => ["001", "002"], "video" => ["001"] }, "mp4", "002"],
      ]
    end
    with_them do
      it "pour attribuer une numerotation" do
        dedoublonneur = Dedoublonneur.new([], noms_attribues_par_extension)
        expect(dedoublonneur.attribution_par_numero(extension)).to eq attendu
      end
    end
  end
end
