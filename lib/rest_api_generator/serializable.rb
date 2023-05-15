# frozen_string_literal: true

require "active_support"
require "active_support/concern"

module RestApiGenerator
  module Serializable
    extend ActiveSupport::Concern

    def serializer(resource)
      resource
    end

    def index_serializer(resources)
      serializer(resources)
    end
  end
end
