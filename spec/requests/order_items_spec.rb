# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrderItems' do
  describe 'POST /order_items' do
    it 'adds a real order item to the current order' do
      product = create(:product, price: 50)

      expect do
        post order_items_path, params: {order_item: {product_id: product.id, quantity: 3}}, as: :turbo_stream
      end.to change(OrderItem, :count).by(1)

      order_item = OrderItem.last
      expect(order_item.product_id).to eq(product.id)
      expect(order_item.quantity).to eq(3)
      expect(order_item.ordering_id).to be_nil
      expect(order_item.order_id).to eq(session[:order_id])
    end
  end

  describe 'PATCH /order_items/:id' do
    it "updates the item's quantity" do
      product = create(:product, price: 20)
      post order_items_path, params: {order_item: {product_id: product.id, quantity: 1}}, as: :turbo_stream
      order_item = OrderItem.last

      patch order_item_path(order_item), params: {order_item: {quantity: 5}}, as: :turbo_stream
      expect(response).to have_http_status(:success)
      expect(order_item.reload.quantity).to eq(5)
    end
  end

  describe 'DELETE /order_items/:id' do
    it 'destroys the item' do
      product = create(:product, price: 20)
      post order_items_path, params: {order_item: {product_id: product.id, quantity: 1}}, as: :turbo_stream
      order_item = OrderItem.last

      expect do
        delete order_item_path(order_item), as: :turbo_stream
      end.to change(OrderItem, :count).by(-1)
    end
  end
end
