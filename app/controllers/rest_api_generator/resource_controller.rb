# frozen_string_literal: true

module RestApiGenerator
  class ResourceController < RestApiGenerator.configuration.parent_controller.constantize
    include ControllerCallbacks
    include Orderable
    include Serializable
    include ResourceParams

    before_action :set_resource, only: [:show, :update, :destroy]

    def index
      set_all_resources
      @resources = @resources.filter_resource(params_for_filter) if resource_class.include?(Filterable)
      @resources = @resources.order(ordering_params(params[:sort])) if params[:sort]
      if pagination
        @pagy, @resources = pagy(@resources)
        pagy_headers_merge(@pagy)
      end
      render json: index_serializer(@resources), status: :ok
    end

    def show
      render json: serializer(@resource), status: :ok
    end

    def create
      @resource = resource_class.create!(resource_created_params)
      render json: serializer(@resource), status: :created
    end

    def update
      @resource.update!(resource_updated_params)
      render json: serializer(@resource), status: :ok
    end

    def destroy
      @resource.destroy!
    end

    private

    def set_resource
      run_callbacks :set_resource do
        @resource = resource_class.find(record_id)
      end
    end

    def set_all_resources
      run_callbacks :set_all_resources do
        @resources = resource_class.all
      end
    end

    # UsersController => User
    def resource_by_controller_name(controller_name = self.class.to_s)
      controller_name.split(Regexp.union(["Controller", "::"]))[-1].singularize.constantize
    end

    def record_id
      params.permit(:id)[:id]
    end

    def pagination
      RestApiGenerator.configuration.pagination
    end
  end
end
