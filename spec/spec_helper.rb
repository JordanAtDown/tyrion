# frozen_string_literal: true

require "rspec-parameterized"

require "tyrion"
require "helpers/file_helpers"

RSpec.configure do |config|
  # Include helpers
  config.include FileHelpers

  # Enable mocha library for mocking and stubbing
  config.mock_with :mocha

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
