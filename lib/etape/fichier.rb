# frozen_string_literal: true

module TraitementEtape
  # Fichier
  class Fichier
    attr_reader :nom_attribue, :date
  
    def initialize(nom_attribue, date)
      @nom_attribue = nom_attribue
      @date = date
    end
  end
end
