# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts' do
  describe 'GET /cart' do
    it 'renders successfully' do
      get cart_path
      expect(response).to have_http_status(:success)
    end

    it "renders an empty cart, not a 500, when the session's order was deleted" do
      product = create(:product)
      post order_items_path, params: {order_item: {product_id: product.id, quantity: 1}}, as: :turbo_stream
      order_id = OrderItem.last.order_id
      # Deletes just this order (not Order.destroy_all - stray Orderings
      # from earlier, non-transactional data on this app's shared dev/
      # test database would violate a foreign key otherwise), simulating
      # it disappearing by any means, not just this app's own flow.
      # Order#order_items is dependent: :destroy, so this cascades cleanly.
      Order.find(order_id).destroy

      get cart_path
      expect(response).to have_http_status(:success)
    end
  end
end
