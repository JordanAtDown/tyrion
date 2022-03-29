# frozen_string_literal: true

module Tyrion
  # Configuration
  class Configuration
    attr_reader :apply, :destination

    def initialize(apply, destination)
      @apply = apply
      @destination = destination
    end
  end
end
