# frozen_string_literal: true

require "date"

# AnalyseErreur
class AnalyseErreur < StandardError; end

# Analyseur
class Analyseur
  attr_accessor :regex_patterns

  def initialize
    @regex_patterns = {
      /(IMG|VID|PANO)_([0-9]{8})_([0-9]{6})/ => Extracteur.new.method(:analyse1),
      /(IMG|VID|PANO)_([0-9]{8})_([0-9]{4})/ => Extracteur.new.method(:analyse2),
      /(IMG|VID)_([0-9]{8})_([0-9]{4})-([0-9]{2})/ => Extracteur.new.method(:analyse2),
      /(IMG|VID)_([0-9]{14})/ => Extracteur.new.method(:analyse3),
      /([0-9]{8})_([0-9]{6})_([0-9]{3})/ => Extracteur.new.method(:analyse4),
      /([0-9]{8})_([0-9]{6})_([0-9]{3}) (\([0-9]\))/ => Extracteur.new.method(:analyse4),
      /([0-9]{8})_([0-9]{6})/ => Extracteur.new.method(:analyse4),
      /^(Resized)_([0-9]{8})_([0-9]{6})_([0-9]{5})$/ => Extracteur.new.method(:analyse4),
      /[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}\.[0-9]{2}\.[0-9]{2}/ => Extracteur.new.method(:analyse5),
      /^([0-9]{4})-([0-9]{2})-([0-9]{2}) ([0-9]{2})\.([0-9]{2})\.([0-9]{2})-([0-9]{1})$/ => Extracteur.new.method(:analyse5),
      /([0-9]{2})-([0-9]{2})-([0-9]{4}) ([0-9]{2})-([0-9]{2})-([0-9]{2})/ => Extracteur.new.method(:analyse8),
      /(PHOTO|Photo|photo)-([0-9]{4})-([0-9]{2})-([0-9]{2})-([0-9]{2})-([0-9]{2})-([0-9]{2})/ => Extracteur.new.method(:analyse6),
      /(photo)_([0-9]{4})_([0-9]{2})_([0-9]{2})-([0-9]{2})_([0-9]{2})_([0-9]{2})/ => Extracteur.new.method(:analyse7),
      /(photo)_([0-9]{4})_([0-9]{2})_([0-9]{2})-([0-9]{2})_([0-9]{2})_([0-9]{2})-([0-9]{2})/ => Extracteur.new.method(:analyse7)
    }
  end

  def analyse(nom)
    regex_patterns.each_pair do |key, value|
      next unless key =~ nom

      return value.call(nom)
    end
    raise AnalyseErreur, "Aucune date n'est defini"
  end

  def est_analysable(nom)
    est_analysable = false
    regex_patterns.each_key do |key|
      est_analysable = true if key =~ nom
    end
    est_analysable
  end
end

# Extracteur
class Extracteur
  def analyse1(nom)
    nom_split = nom.split("_")
    date = nom_split[1]
    instant = nom_split[2]
    DateTime.parse("#{date}T#{instant}")
  end

  def analyse2(nom)
    nom_split = nom.split("_")
    date = nom_split[1]
    annee = date[4..7]
    mois = date[2..3]
    jour = date[0..1]
    instant = nom_split[2].split("-")[0]
    DateTime.parse("#{annee}#{mois}#{jour}T#{instant}00")
  end

  def analyse3(nom)
    nom_split = nom.split("_")
    date = nom_split[1][0..7]
    instant = nom_split[1][8..13]
    DateTime.parse("#{date}T#{instant}")
  end

  def analyse4(nom)
    nom_split = nom.split("_")
    if nom =~ /Resized/
      DateTime.parse("#{nom_split[1]}T#{nom_split[2]}")
    else
      DateTime.parse("#{nom_split[0]}T#{nom_split[1]}")
    end
  end

  def analyse5(nom)
    nom_split = nom.split(" ")
    date = nom_split[0].gsub("-", "")
    instant = nom_split[1].gsub(".", "").split("-")[0]
    DateTime.parse("#{date}T#{instant}")
  end

  def analyse6(nom)
    nom_split = nom.split("-")
    date = "#{nom_split[1]}#{nom_split[2]}#{nom_split[3]}"
    seconde = nom_split[6][0..1]
    instant = "#{nom_split[4]}#{nom_split[5]}#{seconde}"
    DateTime.parse("#{date}T#{instant}")
  end

  def analyse7(nom)
    nom_split = nom.split("-")
    date_split = nom_split[0].split("_")
    date = "#{date_split[1]}#{date_split[2]}#{date_split[3]}"
    instant_split = nom_split[1].split("_")
    seconde = instant_split[2][0..1]
    instant = "#{instant_split[0]}#{instant_split[1]}#{seconde}"
    DateTime.parse("#{date}T#{instant}")
  end

  def analyse8(nom)
    nom_split = nom.split(" ")
    date_split = nom_split[0].split("-")
    date = "#{date_split[2]}#{date_split[1]}#{date_split[0]}"
    instant = nom_split[1].gsub("-", "")
    DateTime.parse("#{date}T#{instant}")
  end
end
