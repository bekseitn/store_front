# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products' do
  describe 'GET /products' do
    it 'renders successfully' do
      get products_path
      expect(response).to have_http_status(:success)
    end
  end
end
