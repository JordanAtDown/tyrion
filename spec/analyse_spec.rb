# frozen_string_literal: true

require "analyse"

RSpec.describe Analyse do
  describe "doit calculer le taux" do
    where(:case_name, :dossier_analyse, :attendu) do
      [
        ["de la liste [true, true, true, true]", [true, true, true, true], 100],
        ["de la liste [true, false, true, true]", [true, false, true, true], 75],
        ["de la liste [true, true, false, false]", [true, true, false, false], 50],
        ["de la liste [false, false, false, false]", [false, false, false, false], 0]
      ]
    end
    with_them do
      it "qui est analysable" do
        expect(Analyse.new(dossier_analyse).calcul_taux_analyse).to eq attendu
      end
    end
  end
end
