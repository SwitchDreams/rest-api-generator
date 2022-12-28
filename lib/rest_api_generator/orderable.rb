# frozen_string_literal: true

require "active_support/concern"

module RestApiGenerator
  module Orderable
    extend ActiveSupport::Concern

    SORT_ORDER = { " " => :asc, "+" => :asc, "-" => :desc }

    # Returns params for order in active record order syntax
    # GET /api/v1/transactions?sort=-amount
    #
    # ordering_params(params) # => { amount: :desc }
    def ordering_params(order_params)
      ordering = {}
      if order_params
        sorted_params = order_params.split(",")
        sorted_params.each do |attr|
          sort_sign = /\A[ +-]/.match?(attr) ? attr.slice!(0) : "+"
          if resource_class.attribute_names.include?(attr)
            ordering[attr] = SORT_ORDER[sort_sign]
          end
        end
      end
      ordering
    end
  end
end
