# frozen_string_literal: true

# File helpers
module FileHelpers
  def self.nombre_fichiers(dossier)
    Dir.glob(File.join(dossier, "**", "*")).select { |file| File.file?(file) }.count
  end
end
