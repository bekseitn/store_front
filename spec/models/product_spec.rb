# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  it 'is invalid without a name' do
    expect(build(:product, name: nil)).not_to be_valid
  end

  it 'is invalid without a category' do
    expect(build(:product, category: nil)).not_to be_valid
  end
end
