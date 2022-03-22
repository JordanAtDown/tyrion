# frozen_string_literal: true

require "file_type"

module ClassificateurParExtensions
  EXTENSIONS_PAR_PREFIXE = {
    /jpg|jpeg|png|raw/ => FileType::PHOTO,
    /mp4/ => FileType::VIDEO
  }.freeze

  def self.get_type(extension)
    type = FileType::OTHER
    EXTENSIONS_PAR_PREFIXE.each_pair do |key, value|
      if key =~ extension[/[a-zA-Z0-9]+/].downcase
        type = value
      end
    end
    type
  end
end
