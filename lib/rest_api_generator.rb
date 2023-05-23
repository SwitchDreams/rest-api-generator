# frozen_string_literal: true

require "rails"
require_relative "rest_api_generator/version"
require_relative "rest_api_generator/error_handler"
require_relative "rest_api_generator/config"
require_relative "rest_api_generator/custom_error"
require_relative "rest_api_generator/helpers/render"
require_relative "rest_api_generator/filterable"
require_relative "rest_api_generator/orderable"
require_relative "rest_api_generator/serializable"
require_relative "rest_api_generator/controller_callbacks"

module RestApiGenerator
  class Error < StandardError; end

  def self.configuration
    @config ||= Config.new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end

require "rest_api_generator/rails" if defined?(Rails)
