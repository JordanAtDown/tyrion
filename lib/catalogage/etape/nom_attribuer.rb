# frozen_string_literal: true

require "nom_attributeur"
require "dedoublonneur"

module Catalogage
  module Etape
    # Dedoublonne et attribut un nom
    class NomAttribuer
      def attribut(fichiers_analyses_par_dossier)
        fichiers_analyses_par_dossier.each_value do |dossier|
          dedoublonneur = Dedoublonneur.new
          dossier.each do |fichier_analyse|
            unless fichier_analyse.date_extraite.nil?
              nom_attribue = dedoublonneur.dedoublonne_par_numerotation(
                NomAttributeur.attribut_par(fichier_analyse.extension,
                                            fichier_analyse.date_extraite))
              fichier_analyse.nom_attribue = nom_attribue
            end
          end
        end
      end
    end
  end
end
