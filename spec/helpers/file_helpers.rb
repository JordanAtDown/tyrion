# frozen_string_literal: true

module FileHelpers
  TMP = "/tmp/"

  def self.build_fichiers(fichiers, dossier)
    fichiers.each_pair do |key, value|
      chemin_dossier = "#{dossier}#{key}"
      dossier_cree = FileUtils.makedirs(chemin_dossier)
      value.each do |fichier|
        chemin_fichier = "#{dossier_cree[0]}/#{fichier}"
        File.new(chemin_fichier, "a")
      end
    end
  end

  def self.nombre_fichiers(dossier)
    Dir.glob(File.join(dossier, '**', '*')).select { |file| File.file?(file) }.count
  end
end
