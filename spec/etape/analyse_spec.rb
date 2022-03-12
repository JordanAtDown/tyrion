# frozen_string_literal: true

require "etape/analyse"
require "analyseur"

RSpec.describe Analyse do
  describe "doit calculer le taux" do
    where(:case_name, :dossier_analyse, :dossier, :attendu) do
      [
        ["de la liste [true, true, true, true]", { "/tmp/vault/2022/02" => [true, true, true, true] }, "/tmp/vault/2022/02", 100],
        ["de la liste [true, false, true, true]", { "/tmp/vault/2020/01" => [true, false, true, true] }, "/tmp/vault/2020/01", 75],
        ["de la liste [true, true, false, false]", { "/tmp/vault/2021/02" => [true, true, false, false] }, "/tmp/vault/2021/02", 50],
        ["de la liste [false, false, false, false]", { "/tmp/vault/2022/12" => [false, false, false, false] }, "/tmp/vault/2022/12", 0]
      ]
    end
    with_them do
      it "qui est analysable" do
        expect(Analyse.new(dossier_analyse, Analyseur.new).calcul_taux_analyse_pour(dossier)).to eq attendu
      end
    end
  end
end
