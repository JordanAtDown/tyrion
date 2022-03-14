# frozen_string_literal: true

# Dedoublonneur
class Dedoublonneur
  attr_accessor :noms_attribues

  def initialize(noms_attribues = [])
    @noms_attribues = noms_attribues
  end

  def dedoublonne_par_numerotation(nom)
    i = 0
    nom_numerote = nom
    @noms_attribues.each do |nom_attribue|
      if nom_numerote == nom_attribue
        i += 1
        nom_numerote = format("%s-%02d", nom, i)
      end
    end
    @noms_attribues.push(nom_numerote)
    nom_numerote
  end

  def attribution_par_numero
    numero = @noms_attribues.length + 1
    nom_numerote = format("%03d", numero)
    @noms_attribues.push(nom_numerote)
    nom_numerote
  end
end
