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
    class_option :father, type: :string, default: ""
    hook_for :spec, in: "rest_api_generator:spec", default: "rspec"

    def create_service_file
      create_model_files

      template controller_template, controller_path

      # Routes
      if options["scope"].blank? && options["father"].blank?
        route "resources :#{file_name.pluralize}"
      else
        log("You need to manually setup routes files for nested or scoped resource")
      end
    end

    private

    def controller_template
      if options["eject"]
        if options["father"].present?
          "child_api_controller.rb"
        else
          "rest_api_controller.rb"
        end
      elsif options["father"].present?
        "implicit_child_resource_controller.rb"
      else
        "implicit_resource_controller.rb"
      end
    end

    def create_model_files
      g = Rails::Generators::ModelGenerator.new([file_name, build_model_attributes])
      g.destination_root = destination_root
      g.invoke_all
    end

    def build_model_attributes
      attributes.map do |attribute|
        "#{attribute.name}:#{attribute.type}"
      end
    end
  end
end
