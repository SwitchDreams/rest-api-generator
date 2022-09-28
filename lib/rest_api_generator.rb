# frozen_string_literal: true

require_relative "rest_api_generator/version"
require_relative "rest_api_generator/error_handler"
require_relative "rest_api_generator/custom_error"
require_relative "rest_api_generator/helpers/render"

module RestApiGenerator
  class Error < StandardError; end
  # Your code goes here...
end
