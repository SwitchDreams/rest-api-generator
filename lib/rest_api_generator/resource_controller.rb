# frozen_string_literal: true

module RestApiGenerator
  class ResourceController < ApplicationController
    before_action :set_resource, only: [:show, :update, :destroy]

    def index
      @resources = resource_class.all
      render json: @resources, status: :ok
    end

    def show
      render json: @resource, status: :ok
    end

    def create
      @resource = resource_class.create!(resource_params)
      render json: @resource, status: :created
    end

    def update
      @resource.update!(resource_params)
      render json: @resource, status: :ok
    end

    def destroy
      @resource.destroy!
    end

    private

    def resource_class
      resource_by_controller_name
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
