# frozen_string_literal: true

require_relative "lib/rest_api_generator/version"
require_relative "lib/rest_api_generator"

Gem::Specification.new do |spec|
  spec.name = "rest-api-generator"
  spec.version = RestApiGenerator::VERSION
  spec.authors = ["PedroAugustoRamalhoDuarte"]
  spec.email = ["pedro_aduarte@aluno.unb.br"]

  spec.summary = "Build a Ruby on Rails REST API faster"
  spec.description = "This gem helps you to build a Ruby on Rails REST API faster, using a scaffold-like generator that follows the best practices."
  spec.homepage = "https://github.com/SwitchDreams/rest-api-generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/SwitchDreams/rest-api-generator"
  spec.metadata["changelog_uri"] = "https://github.com/SwitchDreams/rest-api-generator"

  spec.files = Dir["{bin,sig,lib,public}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "rest-api-generator.gemspec",
                   "Gemfile", "Gemfile.lock"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]



  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.add_dependency "activerecord", ">= 6.0"
  spec.add_dependency "actionview", ">= 6.0"
  spec.add_dependency "railties", ">= 5.0.0"

  spec.add_development_dependency 'ammeter',  '~> 1.1.5'
  spec.add_development_dependency 'rails', '>= 6.0'
  spec.add_development_dependency 'rspec-rails',  '~> 6.0.0'
  spec.add_development_dependency 'sqlite3'

end
