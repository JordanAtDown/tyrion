# frozen_string_literal: true

require "dossier_par_extension"

RSpec.describe DossierParExtension do
  describe "doit definir" do
    where(:case_name, :extension, :attendu) do
      [
        ["le nom du dossier 'MP4'", ".mp4", "MP4"],
        ["le nom du dossier 'JPG'", ".jpg", "JPG"],
        ["le nom du dossier 'JPG' pour l'extension .jpeg", ".jpeg", "JPG"],
        ["le nom du dossier 'JPG' pour l'extension .JPEG", ".JPEG", "JPG"]
      ]
    end
    with_them do
      it "en fonction d'une extension" do
        expect(DossierParExtension.defini_dossier_par(extension)).to eq attendu
      end
    end
  end
end
