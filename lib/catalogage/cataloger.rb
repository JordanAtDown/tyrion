# frozen_string_literal: true

module Catalogage
  # Cataloger
  class Cataloger
    def initialize(analyse, nom_attributeur, application)
      @analyse = analyse
      @nom_attributeur = nom_attributeur
      @application = application
    end
    
    def process(dossier, destination)
      @analyse.analyser(dossier)
      @nom_attributeur.attribut(@analyse.fichiers_analyses)
      @application.applique(@analyse.fichiers_analyses, destination)
    end
  end
end
