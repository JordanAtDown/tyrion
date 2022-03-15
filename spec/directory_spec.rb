# frozen_string_literal: true

require "directory"

RSpec.describe Directory do
  describe "doit extraire" do
    where(:case_name, :path_dossier, :attendu) do
      [
        ["la date '01/01/2020'", "/tmp/vault/2020/01/", DateTime.new(2020, 1, 1, 0, 0, 0)],
        ["la date '01/02/2020'", "/tmp/vault/2019/02/", DateTime.new(2019, 2, 1, 0, 0, 0)],
        ["la date '01/10/2005'", "/tmp/vault/2005/10/", DateTime.new(2005, 10, 1, 0, 0, 0)]
      ]
    end
    with_them do
      it "du chemin d'un dossier" do
        expect(Directory.get_date(path_dossier)).to eq attendu
      end
    end
  end
end
