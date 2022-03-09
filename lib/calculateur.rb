# frozen_string_literal: true

# /Vault/anneee/mois/fichier
class Calculateur
  def method_name
    result = [true, false, true]
    result.group_by(&:itself).transform_values(&:count)
    # Retourne
  end
end

# /Vault/anneee/mois/fichier
class ParcoursDossier
  def parcours(dossier)
    Dir.glob(dossier) do |fichier|
      if File.file?(fichier)
        puts fichier
      else
        parcours("#{fichier}/*")
      end
    end
  end
end

# Definition des dossiers analysable
class Analyse; end

# Definition des nouveau noms et date de pris de vue
class Traitement; end

# Application des nouveaux nom et date de prise de vue
class Application; end
