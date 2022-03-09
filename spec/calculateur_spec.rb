# frozen_string_literal: true

require "calculateur"
require "fileutils"

RSpec.describe Calculateur do
  it "has behaviour" do
    dossier_tmp = FileUtils.makedirs "/tmp/test01/annee/mois/"
    chemin01 = "#{dossier_tmp[0]}/01.txt"
    File.new(chemin01, "a")
    chemin02 = "#{dossier_tmp[0]}/02.txt"
    File.new(chemin02, "a")
    chemin03 = "#{dossier_tmp[0]}/03.txt"
    File.new(chemin03, "a")

    ParcoursDossier.new.parcours "/tmp/test01/"

  end
end
