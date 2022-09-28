require "rails/generators"
require "generators/rest_api_generator/helpers"
module RestApiGenerator
  class ResourceGenerator < Rails::Generators::NamedBase
    include Helpers
    source_root File.expand_path("templates", __dir__)

    argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"
    class_option :scope, type: :string, default: ""

    API_CONTROLLER_DIR_PATH = "app/controllers"
    API_TEST_DIR_PATH = "spec/requests"

    def create_service_file
      Rails::Generators.invoke("model", [file_name, build_model_attributes])
      generator_path = API_CONTROLLER_DIR_PATH + "/#{file_name.pluralize}_controller.rb"
      test_path = API_TEST_DIR_PATH + "/#{file_name}_spec.rb"
      if options["scope"].empty?
        template "rest_api_controller.rb.erb", generator_path
        template "rest_api_spec.rb.erb", test_path
        routes_string = "resources :#{file_name.pluralize}"
        route routes_string
      else
        template "child_api_controller.rb.erb", generator_path
        template "child_api_spec.rb.erb", test_path
      end
    end

    private

    def build_model_attributes
      model_attributes = []
      attributes.each do |attribute|
        model_attributes << "#{attribute.name}:#{attribute.type}"
      end
      model_attributes
    end
  end
end
