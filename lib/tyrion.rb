# frozen_string_literal: true

require_relative "tyrion/version"

require "tyrion"
require "thor"

module Tyrion
  # Cli
  class CLI < Thor
    desc "hello [name]", "say my name"
    def hello(name)
      if name == "Heisenberg"
        puts "you are goddman right"
      else
        puts "say my name"
      end
    end
  end
end
