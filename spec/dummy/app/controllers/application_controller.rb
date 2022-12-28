# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include RestApiGenerator::ErrorHandler
end
