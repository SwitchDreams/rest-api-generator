module RestApiGenerator
  module ResourceParams
    extend ActiveSupport::Concern

    included do
      def params_for_filter
        params.slice(*resource_class.filter_scopes)
      end

      def resource_class
        resource_by_controller_name
      end

      def resource_created_params
        resource_params
      end

      def resource_updated_params
        resource_params
      end

      def resource_params
        singular_resource_name = resource_class.model_name.singular.to_sym
        if Rails.gem_version < Gem::Version.new("8.0")
          params.require(singular_resource_name).permit(resource_attributes)
        else
          params.expect(singular_resource_name => resource_attributes)
        end
      end

      def resource_attributes
        resource_class.attribute_names.map(&:to_sym)
      end
    end
  end
end