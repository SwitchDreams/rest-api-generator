# frozen_string_literal: true

class Transaction < ApplicationRecord
  include RestApiGenerator::Filterable

  validates :amount, presence: true

  filter_scope :filter_by_side, ->(side) { where(side: side) }
end
