# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreSetting do
  it 'is invalid without a store name' do
    expect(build(:store_setting, store_name: nil)).not_to be_valid
  end

  it 'is invalid without a currency' do
    expect(build(:store_setting, currency: nil)).not_to be_valid
  end

  it 'allows only one record' do
    create(:store_setting)

    expect(build(:store_setting)).not_to be_valid
  end
end
