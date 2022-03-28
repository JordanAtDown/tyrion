# frozen_string_literal: true

module Catalogage
  # Cataloger
  class Cataloger
    def initialize(analyse, nom_attributeur, application, verificateur)
      @analyse = analyse
      @nom_attributeur = nom_attributeur
      @application = application
      @verificateur = verificateur
    end
    
    def process(dossier, configuration)
      @analyse.analyser(dossier)
      @nom_attributeur.attribut(@analyse.fichiers_analyses)
      @verificateur.index(@analyse.fichiers_analyses, configuration.destination)
      if configuration.apply && !@verificateur.conflit.size.positive?
        @application.applique(@analyse.fichiers_analyses, configuration.destination)
      end
    end
  end
end
