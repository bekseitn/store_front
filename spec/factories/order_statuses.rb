# frozen_string_literal: true

FactoryBot.define do
  factory :order_status do
    sequence(:name) { |n| "Статус #{n}" }
  end
end
