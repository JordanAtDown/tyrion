# frozen_string_literal: true

# Definit l'étape d'analyse
class AnalyseEtape
  def parcours(dossier)
    Dir.each_child(dossier) do |nom_fichier|
      fichier = "#{dossier}/#{nom_fichier}"
      if File.file?(fichier)
        # Peux-on extraire une date du nom ?
        # Posséde t-il une metadata utilisable ?
        puts fichier
      else
        parcours(fichier)
        next
      end
    end
  end
end
