# frozen_string_literal: true

require "anyway_config"

Anyway::Settings.default_config_path = ->(_name) { Rails.root ? Rails.root.join("config/rest_api_generator.yml") : "" }

module RestApiGenerator
  class Config < Anyway::Config
    config_name :rest_api_generator

    attr_config test_path: "spec/requests",
      docs_path: "spec/docs",
      parent_controller: "RestApiGenerator::ApplicationController",
      pagination: false
  end
end
