# frozen_string_literal: true

require "rails/generators"
require "generators/rest_api_generator/helpers"

module RestApiGenerator
  module Spec
    class RswagGenerator < Rails::Generators::NamedBase
      include Helpers
      source_root File.expand_path("templates", __dir__)

      argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"
      class_option :eject, type: :boolean, default: false
      class_option :scope, type: :string, default: ""
      class_option :father, type: :string, default: ""

      def create_service_file
        puts "teste"
        template spec_controller_template, controller_test_path
      end

      private

      def spec_routes
        {
          index: initial_route,
          show: initial_route + "/{id}",
          create: initial_route,
          update: initial_route + "/{id}",
          delete: initial_route + "/{id}",
        }
      end

      def controller_test_path
        "#{API_TEST_DIR_PATH}#{scope_path}/#{file_name.pluralize}_spec.rb"
      end

      def spec_controller_template
        if options["father"].present?
          "rswag/resource_controller_spec.rb"
        else
          "rswag/nested_resource_controller_spec.rb"
        end
      end
    end
  end
end
