# frozen_string_literal: true

FactoryBot.define do
  factory :ordering do
    name { 'Тест Тестов' }
    address { 'ул. Тестовая, 1' }
    phone { '+77771234567' }
    city
    order

    # Ordering#set_order_status hardcodes order_status_id = 1 at
    # checkout (see app/models/ordering.rb) - belongs_to :order_status
    # isn't optional, so that row has to actually exist or every
    # factory-built ordering fails validation. Ensuring it here once
    # means specs that just want a valid Ordering don't need to know
    # about this pre-existing quirk.
    before(:create) do
      OrderStatus.find_or_create_by!(id: 1) { |status| status.name = 'Новый' }
    end
  end
end
