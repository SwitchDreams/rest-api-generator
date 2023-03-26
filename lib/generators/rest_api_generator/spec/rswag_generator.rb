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
        template spec_controller_template, controller_test_path
      end

      private

      # Changes nested routes for rswag format
      # Example: /cars/{car.id}/drivers/{id}
      def nested_routes
        return "" if options["father"].blank?

        "#{options["father"].downcase.pluralize}/{#{options["father"].singularize.downcase}_id}"
      end

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
        "#{API_DOCS_DIR_PATH}#{scope_path}/#{file_name.pluralize}_spec.rb"
      end

      def spec_controller_template
        if options["father"].present?
          "rswag/nested_resource_controller_spec.rb"
        else
          "rswag/resource_controller_spec.rb"
        end
      end
    end
  end
end
