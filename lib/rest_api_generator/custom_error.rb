# frozen_string_literal: true

module RestApiGenerator
  class CustomError < StandardError
    attr_reader :status, :error, :message

    def initialize(error: 422, status: :unprocessable_entity, message: "Something went wrong")
      @error = error
      @status = status
      @message = message
      super(msg: message)
    end

    def fetch_json
      Helpers::Render.json(error, message, status)
    end
  end
end
