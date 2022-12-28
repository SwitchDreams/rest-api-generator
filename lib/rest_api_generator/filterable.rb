# frozen_string_literal: true

require "active_support/concern"

module RestApiGenerator
  module Filterable
    extend ActiveSupport::Concern

    included do
      @filter_scopes ||= []
    end

    module ClassMethods
      attr_reader :filter_scopes

      def filter_scope(name, *args)
        scope name, *args
        @filter_scopes << name.to_s.gsub("filter_by_", "").to_sym
      end

      def filter_resource(params)
        results = where(nil)
        params.each do |key, value|
          results = results.public_send("filter_by_#{key}", value) if value.present?
        end
        results
      end
    end
  end
end
