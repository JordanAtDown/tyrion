# frozen_string_literal: true

# Définit l'étape d'application
class ApplicationEtape
  def parcours(fichiers)
    fichiers.each_pair do |key, value|
      if File.file?(key)
        File.rename(key, value.get_nouveau_nom)
      end
    end
  end
end
