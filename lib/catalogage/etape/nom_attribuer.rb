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
            # Dans le cas des fichiers qui vont vers none il faut casser les doublons
            if fichier_analyse.date_extraite.nil?
              fichier_analyse.nom_attribue = dedoublonneur.dedoublonne_par_numerotation(File.basename(fichier_analyse.path, fichier_analyse.extension))
            else
              fichier_analyse.nom_attribue = dedoublonneur.dedoublonne_par_numerotation(
                NomAttributeur.attribut_par(fichier_analyse.extension,
                                            fichier_analyse.date_extraite))

            end
          end
        end
      end
    end
  end
end
