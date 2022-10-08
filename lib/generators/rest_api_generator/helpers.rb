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

    def scope?
      !options["scope"].empty?
    end

    def version
      parts = options["scope"].split(".")
      new_path = parts[0].capitalize
      parts.drop(1).each do |part|
        new_path += '::' + part.capitalize
      end
      "module " + new_path
    end
  end
end
