# frozen_string_literal: true

require 'rspec/logging_helper'
require "rspec-parameterized"
require 'logging'

require "tyrion"
require "helpers/file_helpers"
require "helpers/exif_helpers"
require "helpers/image_helpers"

RSpec.configure do |config|
  include RSpec::LoggingHelper
  config.capture_log_messages
  # Including helpers
  config.include FileHelpers
  config.include ExifHelpers
  config.include ImageHelpers

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
