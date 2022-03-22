# frozen_string_literal: true

require "classificateur_par_extension"

# Dedoublonneur
class Dedoublonneur
  attr_accessor :noms_attribues

  def initialize(noms_attribues = [], noms_attribues_par_extension = {})
    @noms_attribues = noms_attribues
    @noms_attribues_par_extension = noms_attribues_par_extension
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

  def attribution_par_numero(extension)
    type = ClassificateurParExtensions.get_type(extension)
    nom_numerote = ""
    if @noms_attribues_par_extension.has_key?(type)
      numeros_attribues = @noms_attribues_par_extension.fetch(type)
      numero = numeros_attribues.length + 1
      nom_numerote = format("%03d", numero)
      numeros_attribues.push(nom_numerote)
      @noms_attribues_par_extension.merge!({ type => numeros_attribues })
    else
      numero = 1
      nom_numerote = format("%03d", numero)
      numeros_attribues = []
      numeros_attribues.push(nom_numerote)
      @noms_attribues_par_extension.store(type, numeros_attribues)
    end
    nom_numerote
  end
end
