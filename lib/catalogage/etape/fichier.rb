# frozen_string_literal: true

module Catalogage
  module Etape
    # Fichier
    class Fichier
      attr_writer :nom_attribue
      attr_reader :extension, :date_extraite, :exif, :path

      def initialize(path, extension, date_extraite, exif, nom_attribue = nil)
        @date_extraite = date_extraite
        @path = path
        @extension = extension
        @type = ClassificateurParExtensions.get_type(extension)
        @exif = exif
        @nom_attribue = nom_attribue
      end

      def path_destination
        if !@date_extraite.nil?
          "#{@date_extraite.year}/#{format("%02d",
                                           @date_extraite.month)}/#{DossierParExtension.defini_dossier_par(@extension)}"
        else
          "none/#{DossierParExtension.defini_dossier_par(@extension)}"
        end
      end

      def path_nouveau_nom(destination)
        "#{destination}/#{@nom_attribue}#{@extension.downcase}"
      end
    end
  end
end
