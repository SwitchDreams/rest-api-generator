# frozen_string_literal: true

class Transaction < ApplicationRecord
  include RestApiGenerator::Filterable

  filter_scope :filter_by_side, ->(side) { where(side: side) }
end
