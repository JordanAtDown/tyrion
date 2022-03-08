# frozen_string_literal: true

# Renommeur
class Renommeur
  attr_accessor :noms_attribues

  def initialize(noms_attribues)
    @noms_attribues = noms_attribues
  end

  def numerotation(nom)
    i = 0
    nom_numerote = nom
    @noms_attribues.each do |nom_attribue|
      if nom_numerote == nom_attribue
        i += 1
        nom_numerote = "%s-%02d" % [nom, i]
      end
    end
    nom_numerote
  end
end
