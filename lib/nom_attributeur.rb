# frozen_string_literal: true

require "classificateur_par_extension"

module NomAttributeur
  def self.attribut_par(extension, date)
    prefixe = ClassificateurParExtensions.get_type(extension)
    date.strftime("#{prefixe}_%Y_%m_%d-%H_%M_%S")
  end
end
