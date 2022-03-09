# frozen_string_literal: true

class Calculateur
  def method_name
    result = [true, false, true]
    result.group_by(&:itself).map { |k,v| [k, v.count] }.to_h
    # Retourne 
  end
end

# /Vault/anneee/mois/fichier
class ParcoursDossier
  def parcours(dossier)
    # test = Dir.glob(dossier)
    Dir.each_child(dossier) do |fichier|
      is = File.directory?(fichier)
      # if File.directory?(fichier)
      #   chemin = "#{dossier}#{fichier}/"
      #   self.parcours(chemin)
      # end
      is
    end
    
  end
end

# Definition des dossiers analysable
class Analyse; end

# Definition des nouveau noms et date de pris de vue
class Traitement; end

# Application des nouveaux nom et date de prise de vue
class Application; end
