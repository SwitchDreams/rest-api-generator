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
    # class_option :spec, type: :string, default: "rspec", enum: ["rspec", "rswag"]
    hook_for :spec, in: "rest_api_generator:spec", default: "rspec"

    def create_service_file
      create_model_files

      # Create controller and specs
      controller_path = "#{API_CONTROLLER_DIR_PATH}#{scope_path}/#{file_name.pluralize}_controller.rb"

      template controller_template, controller_path

      # Specs
      # if options["spec"] == "rswag"
      #   Rails::Generators.invoke "rest_api_generator:specs:rswag", args
      # else
      #   Rails::Generators.invoke "rest_api_generator:specs:rspec", args
      # end

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
      model_attributes = []
      attributes.each do |attribute|
        model_attributes << "#{attribute.name}:#{attribute.type}"
      end
      model_attributes
    end
  end
end
