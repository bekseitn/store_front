# frozen_string_literal: true

FactoryBot.define do
  factory :ordering do
    name { 'Тест Тестов' }
    address { 'ул. Тестовая, 1' }
    phone { '+77771234567' }
    city
    order

    # order_status_id = 1 is set automatically by Ordering#set_order_status;
    # spec/rails_helper.rb's global `before` ensures that row exists for
    # every spec, not just factory-built orderings.
  end
end
