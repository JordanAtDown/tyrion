# frozen_string_literal: true

module Catalogage
  # Cataloger
  class Cataloger
    def initialize(analyse, nom_attributeur, application)
      @analyse = analyse
      @nom_attributeur = nom_attributeur
      @application = application
    end
    
    def process(dossier, configuration)
      @analyse.analyser(dossier)
      @nom_attributeur.attribut(@analyse.fichiers_analyses)
      @application.applique(@analyse.fichiers_analyses, configuration.destination) if configuration.apply
    end
  end
end
