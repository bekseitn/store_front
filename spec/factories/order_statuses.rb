# frozen_string_literal: true

FactoryBot.define do
  factory :order_status do
    sequence(:name) { |n| "Status #{n}" }
  end
end
