# frozen_string_literal: true

FactoryBot.define do
  factory :store_setting do
    store_name { 'Example Store' }
    currency { 'USD' }
    contact_email { 'hello@example.com' }
    contact_phone { '+1 555 0100' }
    logo_url { 'https://example.com/logo.png' }
  end
end
