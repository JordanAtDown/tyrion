# frozen_string_literal: true

require "etape/analyse_etape"
require "etape/traitement_dossier_extirpable_etape"
require "etape/traitement_dossier_non_extirpable_etape"
require "etape/application_etape"
require "restauration"
require "extracteur_par_date"

RSpec.describe Restauration do
  describe "doit extraire" do
    before do
      @dossier_tmp = FileUtils.makedirs "#{FileHelpers::TMP}test01"
    end

    where(:case_name, :fichiers) do
      [
        ["la date '01/01/2020'", { "/2012/01" => ["01.png", "IMG_20210803175810.png", "03.png"],
                                   "/2012/02" => ["20151231_155747.png", "IMG_20210803175810.jpeg",
                                                  "05-11-2010 21-26-00.png"] }]
      ]
    end
    with_them do
      it "pour attribuer une numerotation" do
        FileHelpers.build_fichiers(fichiers, @dossier_tmp[0])

        Restauration.new(
          AnalyseEtape.new(ExtracteurParDate.new),
          TraitementDossierExtirpableEtape.new(ExtracteurParDate.new),
          TraitementDossierNonExtirpableEtape.new,
          ApplicationEtape.new
        ).process("#{@dossier_tmp[0]}/*", false)
      end

      after do
        FileUtils.rm_rf(@dossier_tmp[0])
      end
    end
  end
end
