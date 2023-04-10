# frozen_string_literal: true

module RestApiGenerator
  class ResourceController < RestApiGenerator.configuration.parent_controller.constantize
    include Orderable

    before_action :set_resource, only: [:show, :update, :destroy]

    def index
      @resources = resource_class.all
      @resources = @resources.filter_resource(params_for_filter) if resource_class.include?(Filterable)
      @resources = @resources.order(ordering_params(params[:sort])) if params[:sort]
      render json: @resources, status: :ok
    end

    def show
      render json: @resource, status: :ok
    end

    def create
      @resource = resource_class.create!(resource_created_params)
      render json: @resource, status: :created
    end

    def update
      @resource.update!(resource_updated_params)
      render json: @resource, status: :ok
    end

    def destroy
      @resource.destroy!
    end

    private

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
      params.require(resource_class.model_name.singular.to_sym).permit(resource_attributes)
    end

    def resource_attributes
      resource_class.attribute_names.map(&:to_sym)
    end

    def set_resource
      @resource = resource_class.find(record_id)
    end

    # UsersController => User
    def resource_by_controller_name(controller_name = self.class.to_s)
      controller_name.split(Regexp.union(["Controller", "::"]))[-1].singularize.constantize
    end

    def record_id
      params.permit(:id)[:id]
    end
  end
end