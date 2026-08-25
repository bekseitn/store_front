# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  before_save :update_total

  def total
    order_items.sum { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }
  end

  private

  def update_total
    self[:total] = total
  end
end
