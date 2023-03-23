# frozen_string_literal: true

require "rails"
require_relative "rest_api_generator/version"
require_relative "rest_api_generator/application_controller"
require_relative "rest_api_generator/error_handler"
require_relative "rest_api_generator/config"
require_relative "rest_api_generator/custom_error"
require_relative "rest_api_generator/helpers/render"
require_relative "rest_api_generator/filterable"
require_relative "rest_api_generator/orderable"

module RestApiGenerator
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Config.new
    end

    def configure
      yield(configuration)
    end
  end


  def self.parent_controller
    "RestApiGenerator::ApplicationController"
  end
end

require_relative "rest_api_generator/resource_controller"
require_relative "rest_api_generator/child_resource_controller"
