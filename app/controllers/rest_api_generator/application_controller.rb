# frozen_string_literal: true

require "action_controller"

module RestApiGenerator
  class ApplicationController < ActionController::Base
    include Pagy::Backend
  end
end
