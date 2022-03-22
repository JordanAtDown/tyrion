# frozen_string_literal: true

# Configuration
class Configuration
  attr_reader :apply

  def initialize(apply)
    @apply = apply
  end
end
