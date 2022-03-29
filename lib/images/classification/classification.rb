# frozen_string_literal: true

# Classification
module Classification
  PHOTO = "photo"
  VIDEO = "video"
  OTHER = "other"

  EXTENSIONS_PAR_PREFIXE = {
    /jpg|jpeg|png|raw/ => PHOTO,
    /mp4|mov/ => VIDEO
  }.freeze

  def self.get_type(extension)
    type = OTHER
    EXTENSIONS_PAR_PREFIXE.each_pair do |key, value|
      type = value if key =~ extension[/[a-zA-Z0-9]+/].downcase
    end
    type
  end
end
