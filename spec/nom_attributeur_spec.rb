# frozen_string_literal: true

require "images/nommage/nom_attributeur"

RSpec.describe NomAttributeur do
  it "Doit attribuer le prefixe photo quand l'extension est un format de photo" do
    expect(NomAttributeur.attribut_par(".jpg", DateTime.new(2021, 1, 10, 10, 5, 10))).to eql "photo_2021_01_10-10_05_10"
    expect(NomAttributeur.attribut_par(".JPEG",
                                       DateTime.new(2021, 1, 10, 10, 5, 10))).to eql "photo_2021_01_10-10_05_10"
    expect(NomAttributeur.attribut_par(".MP4", DateTime.new(2021, 1, 10, 10, 5, 10))).to eql "video_2021_01_10-10_05_10"
    expect(NomAttributeur.attribut_par(".png", DateTime.new(2021, 1, 10, 10, 5, 10))).to eql "photo_2021_01_10-10_05_10"
  end
end
