# frozen_string_literal: true

require "rails/generators"
require "generators/rest_api_generator/helpers"

module RestApiGenerator
  module Spec
    class RspecGenerator < Rails::Generators::NamedBase
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

      def controller_test_path
        "#{API_TEST_DIR_PATH}#{scope_path}/#{file_name.pluralize}_controller_spec.rb"
      end

      def spec_controller_template
        if options["father"].present?
          "rspec/nested_resource_controller_spec.rb"
        else
          "rspec/resource_controller_spec.rb"
        end
      end
    end
  end
end
