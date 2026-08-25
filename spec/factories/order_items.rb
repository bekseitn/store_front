# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    product
    order
    quantity { 1 }
  end
end
