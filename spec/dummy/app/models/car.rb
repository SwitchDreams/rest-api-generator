# frozen_string_literal: true

class Car < ApplicationRecord
  has_many :drivers
end
