# frozen_string_literal: true

require "rest_api_generator/orderable"

module RestApiGenerator
  class ChildResourceController < ApplicationController
    include Orderable

    before_action :set_parent_resource
    before_action :set_resource, only: [:show, :update, :destroy]

    def index
      @resources = resources
      @resources = @resources.filter_resource(params_for_filter) if resource_class.include?(Filterable)
      @resources = @resources.order(ordering_params(params[:sort])) if params[:sort]
      render json: @resources, status: :ok
    end

    def show
      render json: @resource, status: :ok
    end

    def create
      @resource = resources.create!(resource_created_params)
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

    def resources
      @parent_resource.send(resource_class.to_s.downcase.pluralize)
    end

    def parent_resource_class
      parent_resource_by_controller_name
    end

    def resource_class
      resource_by_controller_name
    end

    # Params
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

    def params_for_filter
      params.slice(*resource_class.filter_scopes)
    end

    # Before actions
    def set_parent_resource
      @parent_resource = parent_resource_class.find(parent_record_id)
    end

    def set_resource
      @resource = resources.find(record_id)
    end

    # UsersController => User
    def resource_by_controller_name(controller_name = self.class.to_s)
      controller_name.split(Regexp.union(["Controller", "::"]))[-1].singularize.constantize
    end

    # Users::DevicesController => User
    def parent_resource_by_controller_name(controller_name = self.class.to_s)
      controller_name.split(Regexp.union(["Controller", "::"]))[-2].singularize.constantize
    end

    def parent_record_id
      params.dig("#{parent_resource_class.to_s.downcase.singularize}_id")
    end

    def record_id
      params.permit(:id)[:id]
    end
  end
end
