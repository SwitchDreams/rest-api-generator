# frozen_string_literal: true

class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers do |t|
      t.references :car, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
