# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orderings' do
  describe 'GET /orderings/new' do
    it 'renders successfully' do
      get new_ordering_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /orderings' do
    it 'finalizes the cart: moves items onto the ordering and empties the order' do
      product = create(:product, price: 100)
      order = create(:order)
      order_item = create(:order_item, order: order, product: product, quantity: 2)
      city = create(:city)

      expect do
        post orderings_path, params: {ordering: {
          name: 'Jane Doe',
          address: '123 Main St',
          phone: '555-0100',
          order_id: order.id,
          city_id: city.id
        }}
      end.to change(Ordering, :count).by(1)

      expect(response).to redirect_to(root_path)

      ordering = Ordering.last
      order_item.reload
      expect(order_item.ordering_id).to eq(ordering.id)
      expect(order_item.order_id).to be_nil
      expect(ordering.total).to eq(200) # 2 x 100
      expect(order.reload.order_items).to be_empty
    end
  end
end
