# frozen_string_literal: true

require "date"

# Erreur d'extraction
class ExtractionErreur < StandardError; end

# Extracteur par date
class ExtracteurParDate
  attr_accessor :regex_patterns

  def initialize
    @regex_patterns = {
      /(IMG|VID|PANO)_([0-9]{8})_([0-9]{6})/ => Extraction.new.method(:extract01),
      /(IMG|VID|PANO)_([0-9]{8})_([0-9]{4})/ => Extraction.new.method(:extract02),
      /(IMG|VID)_([0-9]{8})_([0-9]{4})-([0-9]{2})/ => Extraction.new.method(:extract02),
      /(IMG|VID)_([0-9]{14})/ => Extraction.new.method(:extract03),
      /([0-9]{8})_([0-9]{6})_([0-9]{3})/ => Extraction.new.method(:extract04),
      /([0-9]{8})_([0-9]{6})_([0-9]{3}) (\([0-9]\))/ => Extraction.new.method(:extract04),
      /([0-9]{8})_([0-9]{6})/ => Extraction.new.method(:extract04),
      /^(Resized)_([0-9]{8})_([0-9]{6})_([0-9]{5})$/ => Extraction.new.method(:extract04),
      /[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}\.[0-9]{2}\.[0-9]{2}/ => Extraction.new.method(:extract05),
      /^([0-9]{4})-([0-9]{2})-([0-9]{2}) ([0-9]{2})\.([0-9]{2})\.([0-9]{2})-([0-9]{1})$/ => Extraction.new.method(:extract05),
      /([0-9]{2})-([0-9]{2})-([0-9]{4}) ([0-9]{2})-([0-9]{2})-([0-9]{2})/ => Extraction.new.method(:extract08),
      /(PHOTO|Photo|photo|VIDEO)-([0-9]{4})-([0-9]{2})-([0-9]{2})-([0-9]{2})-([0-9]{2})-([0-9]{2})/ => Extraction.new.method(:extract06),
      /(photo)_([0-9]{4})_([0-9]{2})_([0-9]{2})-([0-9]{2})_([0-9]{2})_([0-9]{2})/ => Extraction.new.method(:extract07),
      /(photo)_([0-9]{4})_([0-9]{2})_([0-9]{2})-([0-9]{2})_([0-9]{2})_([0-9]{2})-([0-9]{2})/ => Extraction.new.method(:extract07)
    }
  end

  def extraction_du(nom)
    regex_patterns.each_pair do |key, value|
      next unless key =~ nom

      return value.call(nom)
    end
    raise ExtractionErreur, "Aucune date ne peux être extraite sur '#{nom}'"
  end

  def extirpabilite(nom)
    est_extirpable = false
    regex_patterns.each_key do |key|
      est_extirpable = true if key =~ nom
    end
    est_extirpable
  end
end

# Extraction
class Extraction
  def extract01(nom)
    nom_split = nom.split("_")
    date = nom_split[1]
    instant = nom_split[2]
    DateTime.parse("#{date}T#{instant}")
  end

  def extract02(nom)
    nom_split = nom.split("_")
    date = nom_split[1]
    annee = date[4..7]
    mois = date[2..3]
    jour = date[0..1]
    instant = nom_split[2].split("-")[0]
    DateTime.parse("#{annee}#{mois}#{jour}T#{instant}00")
  end

  def extract03(nom)
    nom_split = nom.split("_")
    date = nom_split[1][0..7]
    instant = nom_split[1][8..13]
    DateTime.parse("#{date}T#{instant}")
  end

  def extract04(nom)
    nom_split = nom.split("_")
    if nom =~ /Resized/
      DateTime.parse("#{nom_split[1]}T#{nom_split[2]}")
    else
      DateTime.parse("#{nom_split[0]}T#{nom_split[1]}")
    end
  end

  def extract05(nom)
    nom_split = nom.split(" ")
    date = nom_split[0].gsub("-", "")
    instant = nom_split[1].gsub(".", "").split("-")[0]
    DateTime.parse("#{date}T#{instant}")
  end

  def extract06(nom)
    nom_split = nom.split("-")
    date = "#{nom_split[1]}#{nom_split[2]}#{nom_split[3]}"
    seconde = nom_split[6][0..1]
    instant = "#{nom_split[4]}#{nom_split[5]}#{seconde}"
    DateTime.parse("#{date}T#{instant}")
  end

  def extract07(nom)
    nom_split = nom.split("-")
    date_split = nom_split[0].split("_")
    date = "#{date_split[1]}#{date_split[2]}#{date_split[3]}"
    instant_split = nom_split[1].split("_")
    seconde = instant_split[2][0..1]
    instant = "#{instant_split[0]}#{instant_split[1]}#{seconde}"
    DateTime.parse("#{date}T#{instant}")
  end

  def extract08(nom)
    nom_split = nom.split(" ")
    date_split = nom_split[0].split("-")
    date = "#{date_split[2]}#{date_split[1]}#{date_split[0]}"
    instant = nom_split[1].gsub("-", "")
    DateTime.parse("#{date}T#{instant}")
  end
end
