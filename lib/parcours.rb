# frozen_string_literal: true

require "etape/etape"

# Parcours Dossier
class Parcours
  attr_reader :etape_analyse

  def initialize(etape_analyse)
    @etape_analyse = etape_analyse
  end

  def parcours(dossier)
    Dir.glob(dossier) do |fichier|
      if File.file?(fichier)
        etape_analyse.analyse_fichier(dossier, fichier)
      else
        parcours("#{fichier}/*")
        next
      end
    end
    result = etape_analyse.calcul_taux_analyse_pour(dossier)
    result
  end
end

# Definition des nouveau noms et date de pris de vue
class Traitement; end

# Application des nouveaux nom et date de prise de vue
class Application; end
