# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    sequence(:name) { |n| "Город #{n}" }
  end
end
