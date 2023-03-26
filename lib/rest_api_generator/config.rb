# frozen_string_literal: true

require "anyway_config"

module RestApiGenerator
  class Config < Anyway::Config
    config_name :rest_api_generator

    attr_config test_path: "spec/requests", docs_path: "spec/docs"
  end
end
