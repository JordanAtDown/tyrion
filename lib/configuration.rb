# frozen_string_literal: true

# Configuration
class Configuration
  attr_reader :apply
  attr_accessor :destination

  def initialize(apply, destination = nil)
    @apply = apply
    @destination = destination
  end
end
