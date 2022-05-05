# frozen_string_literal: true

module RestApiGenerator
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(:record_not_found, 404, e.to_s)
        end
        rescue_from ActiveRecord::ActiveRecordError do |e|
          respond(:active_record_error, 422, e.to_s)
        end
        rescue_from ActiveRecord::RecordInvalid do |e|
          respond(:active_record_invalid, 422, e.to_s)
        end
        rescue_from ActiveModel::ValidationError do |e|
          respond(:active_model_validation_error, 422, e.to_s)
        end
        rescue_from CustomError do |e|
          respond(e.error, e.status, e.message)
        end
      end
    end

    private

    def respond(error, status, message)
      json = Helpers::Render.json(error, status, message)
      render json: json, status: status
    end
  end
end
