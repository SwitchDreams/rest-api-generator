# frozen_string_literal: true

module RestApiGenerator
  module Helpers
    attr_accessor :options, :attributes

    API_CONTROLLER_DIR_PATH = "app/controllers"
    API_TEST_DIR_PATH = ENV.fetch("TEST_PATH") { "spec/requests" }
    API_DOCS_DIR_PATH = ENV.fetch("DOCS_PATH") { "spec/docs" }

    private

    # Columns handlers
    def model_columns_for_attributes
      class_name.singularize.constantize.columns.reject do |column|
        column.name.to_s =~ /^(id|user_id|created_at|updated_at)$/
      end
    end

    def editable_attributes
      @editable_attributes ||= model_columns_for_attributes.map do |column|
        Rails::Generators::GeneratedAttribute.new(column.name.to_s, column.type.to_s)
      end
    end

    # Namespace scope

    def scope_namespacing(&block)
      content = capture(&block)
      content = wrap_with_scope(content) if options["scope"].present? || options["father"].present?
      concat(content)
    end

    def module_namespace
      if options["scope"].present? && options["father"].present?
        options["scope"] + "::" + options["father"]
      else
        options["scope"] + options["father"]
      end
    end

    def wrap_with_scope(content)
      content = indent(content).chomp
      "module #{module_namespace}\n#{content}\nend\n"
    end

    # Paths handlers
    def controller_path
      "#{API_CONTROLLER_DIR_PATH}#{scope_path}/#{file_name.pluralize}_controller.rb"
    end

    def scope_path
      return "" if options["scope"].blank? && options["father"].blank?

      if options["scope"].present? && options["father"].present?
        "/" + option_to_path(options["scope"]) + "/" + option_to_path(options["father"])
      else
        "/" + option_to_path(options["scope"]) + option_to_path(options["father"])
      end
    end

    def option_to_path(option)
      option.downcase.split("::").join("/")
    end

    def scope_route_path
      return "" if options["scope"].blank?

      option_to_path(options["scope"])
    end

    def nested_routes
      return "" if options["father"].blank?

      "#{options["father"].downcase.pluralize}/\#{#{options["father"].singularize.downcase}.id}"
    end

    def initial_route
      route = ""
      route += scope_route_path if options["scope"].present?
      route += options["father"].present? && route.present? ? "/#{nested_routes}" : nested_routes
      route += "/#{plural_name}"
      route[0] == "/" ? route : "/#{route}"
    end

    def spec_routes
      {
        index: initial_route,
        show: initial_route + "/\#{#{singular_name}.id}",
        create: initial_route,
        update: initial_route + "/\#{#{singular_name}.id}",
        delete: initial_route + "/\#{#{singular_name}.id}",
      }
    end
  end
end
