# frozen_string_literal: true

module RegexHelpers
  EXTENSIONS_EXCLUS = /\.(?!(ini|log|1|db-shm|db-wal|db)$)([^.]+$)/.freeze
end
