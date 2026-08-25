# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories' do
  describe 'GET /categories/:id' do
    it 'renders successfully' do
      category = create(:category)
      get category_path(category)
      expect(response).to have_http_status(:success)
    end
  end
end
