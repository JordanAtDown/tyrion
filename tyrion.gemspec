# frozen_string_literal: true

require_relative "lib/tyrion/version"

Gem::Specification.new do |spec|
  spec.name = "tyrion"
  spec.version = Tyrion::VERSION
  spec.authors = ["JordanC0TT"]
  spec.email = ["jordan.content@pm.me"]

  spec.summary = "Catalogage et trie d'une bibliothéque de photos"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency "debase", "~> 0.2.4.1"
  spec.add_development_dependency "mocha", "~> 1.13.0"
  spec.add_development_dependency "rspec-core", "~> 3.11.0"
  spec.add_development_dependency "rspec-parameterized", "~> 0.5.1"
  spec.add_development_dependency "rubocop-rspec", "~> 2.9.0"
  spec.add_development_dependency "ruby-debug-ide", "~> 0.7.3"
  spec.add_development_dependency "solargraph", "~> 0.44.3"
  spec.add_dependency "exif", "~> 2.2.3"
  spec.add_dependency "mini_exiftool_vendored", "~> 9.2.7.v1"
  spec.add_dependency "logging", "~> 2.3.0logging"
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
