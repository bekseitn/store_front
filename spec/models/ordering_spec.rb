# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ordering do
  %i[name address phone city].each do |attribute|
    it "is invalid without #{attribute}" do
      expect(build(:ordering, attribute => nil)).not_to be_valid
    end
  end
end
