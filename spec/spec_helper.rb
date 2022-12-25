# frozen_string_literal: true

require "rails/all"
require "rest_api_generator"

DEFAULT_DESTINATION_PATH = File.expand_path("../tmp", __dir__)

ENV["RAILS_ENV"] = "test"

require_relative "../spec/dummy/config/environment"

ENV["RAILS_ROOT"] ||= "#{File.dirname(__FILE__)}../../../spec/dummy"

require "rspec/rails"
require "ammeter/init"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
