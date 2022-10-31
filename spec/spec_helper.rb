# frozen_string_literal: true

require "rails/all"
require "rest_api_generator"

DEFAULT_DESTINATION_PATH = File.expand_path("../tmp", __dir__)

module RestApiGenerator
  class Application < ::Rails::Application
    config.secret_key_base = "ASecretString"

    config.generators do |g|
      g.orm :active_record
      g.test_framework nil
    end
  end
end

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)
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
