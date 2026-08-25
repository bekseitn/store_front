# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts' do
  describe 'GET /cart' do
    it 'renders successfully' do
      get cart_path
      expect(response).to have_http_status(:success)
    end
  end
end
