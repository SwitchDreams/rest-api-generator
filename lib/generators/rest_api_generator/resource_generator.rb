# frozen_string_literal: true

require "rails/generators"
require "rails/generators/active_model"
require "rails/generators/rails/model/model_generator"
require "generators/rest_api_generator/helpers"
module RestApiGenerator
  class ResourceGenerator < Rails::Generators::NamedBase
    include Helpers
    source_root File.expand_path("templates", __dir__)

    argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"
    class_option :eject, type: :boolean, default: false
    class_option :scope, type: :string, default: ""

    API_CONTROLLER_DIR_PATH = "app/controllers"
    API_TEST_DIR_PATH = "spec/requests"

    def create_service_file
      create_model_files

      # Create controller and specs
      scope_path = options["scope"].present? ? "/#{options["scope"].pluralize}" : ""
      controller_path = "#{API_CONTROLLER_DIR_PATH}#{scope_path}/#{file_name.pluralize}_controller.rb"
      controller_test_path = "#{API_TEST_DIR_PATH}#{scope_path}/#{file_name.pluralize}_controller_spec.rb"

      template controller_template, controller_path
      template spec_controller_template, controller_test_path

      route "resources :#{file_name.pluralize}"
    end

    private

    def controller_template
      if options["eject"]
        "implicit_resource_controller.rb"
      elsif options["scope"].present?
        "child_api_controller.rb"
      else
        "rest_api_controller.rb"
      end
    end

    def spec_controller_template
      if options["scope"].present?
        "child_api_spec.rb"
      else
        "rest_api_spec.rb"
      end
    end

    def create_model_files
      g = Rails::Generators::ModelGenerator.new([file_name, build_model_attributes])
      g.destination_root = destination_root
      g.invoke_all
    end

    def build_model_attributes
      model_attributes = []
      attributes.each do |attribute|
        model_attributes << "#{attribute.name}:#{attribute.type}"
      end
      model_attributes
    end
  end
end
