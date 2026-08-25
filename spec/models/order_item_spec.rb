# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem do
  it 'is invalid without a quantity' do
    expect(build(:order_item, quantity: nil)).not_to be_valid
  end

  it 'is invalid with a zero quantity' do
    expect(build(:order_item, quantity: 0)).not_to be_valid
  end

  it 'is invalid without a product' do
    expect(build(:order_item, product: nil)).not_to be_valid
  end

  it 'is invalid without an order' do
    expect(build(:order_item, order: nil)).not_to be_valid
  end
end
