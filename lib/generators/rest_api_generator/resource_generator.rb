# frozen_string_literal: true

require "rails/generators"
require "generators/rest_api_generator/helpers"
module RestApiGenerator
  class ResourceGenerator < Rails::Generators::NamedBase
    include Helpers
    source_root File.expand_path("templates", __dir__)

    argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"
    class_option :scope, type: :string, default: ""

    API_CONTROLLER_DIR_PATH = "app/controllers"
    API_TEST_DIR_PATH = "spec/requests"

    def create_service_file
      Rails::Generators.invoke("model", [file_name, build_model_attributes])
      controller_path = "#{define_scope}/#{file_name.pluralize}_controller.rb"
      controller_test_path = "#{API_TEST_DIR_PATH}/#{file_name.pluralize}_controller_spec.rb"
      template define_template, controller_path
      template "rest_api_spec.rb", controller_test_path
      routes_string = "resources :#{file_name.pluralize}"
      route routes_string
    end

    private

    def build_model_attributes
      model_attributes = []
      attributes.each do |attribute|
        model_attributes << "#{attribute.name}:#{attribute.type}"
      end
      model_attributes
    end

    def define_scope
      if options["scope"].empty?
        API_CONTROLLER_DIR_PATH
      else
        parts = options["scope"].split(".")
        new_path = ""
        parts.each do |part|
          new_path += '/' + part
        end
        API_CONTROLLER_DIR_PATH + new_path
      end
    end

    def define_template
      if options["scope"].empty?
        "rest_api_controller.rb"
      else
        "scope_rest_api_controller.rb"
      end
    end

  end
end
