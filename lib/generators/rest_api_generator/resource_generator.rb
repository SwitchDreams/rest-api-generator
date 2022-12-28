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
        "rest_api_controller.rb"
      elsif options["scope"].present?
        "child_api_controller.rb"
      else
        "implicit_resource_controller.rb"
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


    def define_path
      path = define_scope
      define_father(path)
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

    def define_father(path)
      if options["father"].empty?
        path
      else
        path + '/' + options["father"].pluralize.downcase
      end
    end


    def define_template
      templates = {}
      if options["father"].empty?
        if options["scope"].empty?
          templates[:controller] = "rest_api_controller.rb"
          templates[:test] = "rest_api_spec.rb"
        else
          templates[:controller] = "scope_rest_api_controller.rb"
          templates[:test] = "rest_api_spec.rb"
        end
      else
        if options["scope"].empty?
          templates[:controller] = "child_api_controller.rb"
          templates[:test] = "child_api_spec.rb"
        else
          templates[:controller] = "scope_child_api_controller.rb"
          templates[:test] = "child_api_spec.rb"
        end
      end
      templates
    end

    def define_routes
      if options["father"].empty? and options['scope'].empty?
        route "resources :#{file_name.pluralize}"
      else
        route_namespaced_resources(options['father'], file_name.pluralize)
      end
    end

    def add_tabs(tab_count)
      tabs = ""
      for a in 0..tab_count do
        tabs += "\t"
      end
      tabs
    end

    def route_namespaced_resources(father, child)
      namespaces = ""
      ends = ""
      tab_ends = ""
      test = "\t"
      tab_count = 1
      if !options['scope'].empty?
        parts = options["scope"].split(".")
        for j in 1..parts.count do
          tab_ends += "\t"
          test += "\t"
        end
        parts.each do |part|
          namespaces += "namespace '#{part}' do\n#{add_tabs(tab_count)}"
          ends += "#{tab_ends}end\n"
          tab_count += 1
          tab_ends.slice!(-1)
        end
      end
      if !options['father'].empty?
        if namespaces.empty?
          sentinel = 'Rails.application.routes.draw do'
          gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
            "#{match}\n  resources :#{father.downcase.pluralize}, module: :#{father.downcase.pluralize} do\n    resources :#{child.downcase.pluralize}\n  end"
          end
        else
          sentinel = 'Rails.application.routes.draw do'
          gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
            "#{match}\n   #{namespaces}resources :#{father.downcase.pluralize},  module: :#{father.downcase.pluralize} do\n#{test + "\t"}resources :#{child.downcase.pluralize}\n#{test}end\n#{ends}"
          end
        end
      else
        sentinel = 'Rails.application.routes.draw do'
        gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
          "#{match}\n  #{namespaces}  resources :#{child.downcase.pluralize}\n#{ends}"
        end
      end
    end
  end
end
