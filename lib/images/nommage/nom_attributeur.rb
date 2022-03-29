# frozen_string_literal: true

require "images/classification/classification"

# NomAttributeur
module NomAttributeur
  def self.attribut_par(extension, date)
    prefixe = Classification.get_type(extension)
    date.strftime("#{prefixe}_%Y_%m_%d-%H_%M_%S")
  end
end
