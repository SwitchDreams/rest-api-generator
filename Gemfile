# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in rest-api-generator.gemspec
gemspec

rails_version = ENV["RAILS_VERSION"] || "8.0"
gem "rails", "~> #{rails_version}"

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"

gem "switchcop"

gem "sqlite3"

# Serializers

# TODO: waiting for https://github.com/yosiat/panko_serializer/issues/166
if Gem::Version.new(rails_version) >= Gem::Version.new("8.0")
  gem "panko_serializer", github: "yosiat/panko_serializer", branch: "master"
else
  gem "panko_serializer"
end



gem "active_model_serializers", "~> 0.10.0"
