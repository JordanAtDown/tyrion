# frozen_string_literal: true

# Analyse notification
class AnalyseNotification
  attr_reader :dossier, :taux

  def initialize(dossier, taux)
    @dossier = dossier
    @taux = taux
  end
end
