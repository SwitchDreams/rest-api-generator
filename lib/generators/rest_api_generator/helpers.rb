# frozen_string_literal: true

module RestApiGenerator
  module Helpers
    attr_accessor :options, :attributes

    private

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

    def option_to_path(option)
      option.downcase.split("::").join("/")
    end

    def scope_route_path
      return "" if options["scope"].blank?

      option_to_path(options["scope"])
    end

    def nested_routes
      return "" if options["father"].blank?

      "#{options["father"].downcase.pluralize}/\#{#{options["father"].singularize.downcase}.id}/#{plural_name}"
    end

    def initial_route
      scope_route_path + "/" + nested_routes
    end

    def spec_routes
      {
        index: initial_route,
        show: initial_route + "\#{#{singular_name}.id}",
        create: initial_route,
        update: initial_route + "\#{#{singular_name}.id}",
        delete: initial_route + "\#{#{singular_name}.id}",
      }
    end
  end
end
