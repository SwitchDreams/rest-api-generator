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
      if options['father'].empty?
        "module " + new_path
      else
        "module " + new_path + '::' + options['father'].pluralize.capitalize
      end
    end

    def child_spec_routes
      routes = {}
      if !options['scope'].empty?
        parts = options["scope"].split(".")
        new_path = ""
        parts.each do |part|
          new_path += '/' + part
        end
        routes[:index] = "#{new_path}/#{options['father'].downcase.pluralize}/" + '#{' + "#{options['father'].singularize.downcase}.id}/" + "/#{plural_name}"
        routes[:show] = "#{new_path}/#{options['father'].downcase.pluralize}/"+ '#{' + "#{options['father'].singularize.downcase}.id}/" +"#{plural_name}/" + '#{' + "#{singular_name}.id}"
        routes[:create] = "#{new_path}/#{options['father'].downcase.pluralize}/" '#{' + "#{options['father'].singularize.downcase}.id}/"+"#{plural_name}/"
        routes[:update] = "#{new_path}/#{options['father'].downcase.pluralize}/" '#{' + "#{options['father'].singularize.downcase}.id}/"+"#{plural_name}/" + '#{' + "#{singular_name}.id}"
        routes[:delete] = "#{new_path}/#{options['father'].downcase.pluralize}/" '#{' + "#{options['father'].singularize.downcase}.id}/"+"#{plural_name}/" + '#{item.id}'
      else
        routes[:index] = "/#{options['father'].downcase.pluralize}/"+'#{' + "#{options['father'].singularize.downcase}.id}/"+"#{plural_name}/"
        routes[:show] = "/#{options['father'].downcase.pluralize}/"+ '#{' + "#{soptions['father'].singularize.downcase}.id}/"+"#{plural_name}/" + '#{' + "#{singular_name}.id}"
        routes[:create] = "/#{options['father'].downcase.pluralize}/"+'#{' + "#{options['father'].singularize.downcase}.id}/"+"#{plural_name}/"
        routes[:update] = "/#{options['father'].downcase.pluralize}/"+'#{' + "#{options['father'].singularize.downcase}.id}/"+"#{plural_name}/" + '#{' + "#{singular_name}.id}"
        routes[:delete] = "/#{options['father'].downcase.pluralize}/"'#{' + "#{options['father'].singularize.downcase}.id}/"+"#{plural_name}/" + '#{item.id}'
      end
      routes
    end

    def scoped_spec_routes
      routes = {}
      routes[:index] = "/#{plural_name}"
      routes[:show] = "/#{plural_name}/"+ '#{' + "#{singular_name}.id}"
      routes[:create] = "/#{plural_name}"
      routes[:update] = "/##{plural_name}/" +  '#{' + "#{singular_name}.id}"
      routes[:delete] = "/#{plural_name}/" + '#{item.id}'
      if !options['scope'].empty?
        parts = options["scope"].split(".")
        new_path = ""
        parts.each do |part|
          new_path += '/' + part
        end
        routes[:index] = "#{new_path}/#{plural_name}"
        routes[:show] = "#{new_path}/#{plural_name}/" + '#{' + "#{singular_name}.id}"
        routes[:create] = "#{new_path}/#{plural_name}"
        routes[:update] = "#{new_path}/#{plural_name}/" + '#{' + "#{singular_name}.id}"
        routes[:delete] = "#{new_path}/#{plural_name}/" + '#{item.id}'
      end
      routes
    end
  end
end
