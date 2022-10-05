# frozen_string_literal: true

require_relative "lib/rest_api_generator/version"

Gem::Specification.new do |spec|
  spec.name = "rest-api-generator"
  spec.version = RestApiGenerator::VERSION
  spec.authors = ["PedroAugustoRamalhoDuarte"]
  spec.email = ["pedro_aduarte@aluno.unb.br"]

  spec.summary = "Build a rails rest api in minutes"
  spec.description = "Generates rest api in SwitchDreams default faster with rest-api-generator"
  spec.homepage = "https://github.com/SwitchDreams/rest-api-generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/SwitchDreams/rest-api-generator"
  spec.metadata["changelog_uri"] = "https://github.com/SwitchDreams/rest-api-generator"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_runtime_dependency("railties", ">= 5.0.0")

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
