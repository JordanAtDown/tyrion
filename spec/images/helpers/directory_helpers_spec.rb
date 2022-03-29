# frozen_string_literal: true

require "images/helpers/directory_helpers"

RSpec.describe DirectoryHelpers do
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
        expect(DirectoryHelpers.defini_dossier_par(extension)).to eq attendu
      end
    end
  end

  describe "doit extraire" do
    where(:case_name, :path_dossier, :attendu) do
      [
        ["la date '01/01/2020'", "/tmp/vault/2020/01/", DateTime.new(2020, 1, 1, 0, 0, 0)],
        ["la date '01/02/2020'", "/tmp/vault/2019/02/", DateTime.new(2019, 2, 1, 0, 0, 0)],
        ["la date '01/10/2005'", "/tmp/vault/2005/10/", DateTime.new(2005, 10, 1, 0, 0, 0)],
        ["la date '01/12/2021'", "/mnt/d/backup/test/Vault/2021/12/", DateTime.new(2021, 12, 1, 0, 0, 0)]
      ]
    end
    with_them do
      it "du chemin d'un dossier" do
        expect(DirectoryHelpers.get_date(path_dossier)).to eq attendu
      end
    end
  end
end
