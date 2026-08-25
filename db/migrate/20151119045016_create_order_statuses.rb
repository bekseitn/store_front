# frozen_string_literal: true

class CreateOrderStatuses < ActiveRecord::Migration[4.2]
  def change
    create_table :order_statuses do |t|
      t.string :name
    end
  end
end
