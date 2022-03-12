# frozen_string_literal: true

# Parcours Dossier
class Parcours
  def parcours(dossier)
    Dir.glob(dossier) do |fichier|
      if File.file?(fichier)
        puts fichier
      else
        parcours("#{fichier}/*")
        next
      end
    end
  end
end

# Definition des nouveau noms et date de pris de vue
class Traitement; end

# Application des nouveaux nom et date de prise de vue
class Application; end
