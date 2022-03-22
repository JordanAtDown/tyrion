# frozen_string_literal: true

module FileHelpers
  TMP = "/tmp/"
  RESSOURCES = File.expand_path("../../resources/", __FILE__)

  IMAGE = "image.b64"
  VIDEO = "video.b64"

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
    Dir.glob(File.join(dossier, "**", "*")).select { |file| File.file?(file) }.count
  end

  def self.generer_(path, type)
    encode = Base64.encode64(File.open(path).read)
    fichier = "#{RESSOURCES}/#{type}"
    File.open(fichier, "wb") do |f|
      f.write(encode.gsub(/\n/, ""))
    end
  end
end
