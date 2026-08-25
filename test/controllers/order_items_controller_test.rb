# frozen_string_literal: true

require 'test_helper'

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  test 'create adds a real order item to the current order' do
    product = Product.create!(name: 'Test chair', price: 50, active: true, category: categories(:one))

    assert_difference('OrderItem.count', 1) do
      post order_items_path(format: :js), params: {order_item: {product_id: product.id, quantity: 3}}
    end

    order_item = OrderItem.last
    assert_equal product.id, order_item.product_id
    assert_equal 3, order_item.quantity
    assert_nil order_item.ordering_id
    assert_equal session[:order_id], order_item.order_id
  end

  test "should update the item's quantity" do
    product = Product.create!(name: 'Test chair', price: 20, active: true, category: categories(:one))
    post order_items_path(format: :js), params: {order_item: {product_id: product.id, quantity: 1}}
    order_item = OrderItem.last

    patch order_item_path(order_item, format: :js), params: {order_item: {quantity: 5}}
    assert_response :success
    assert_equal 5, order_item.reload.quantity
  end

  test 'should destroy the item' do
    product = Product.create!(name: 'Test chair', price: 20, active: true, category: categories(:one))
    post order_items_path(format: :js), params: {order_item: {product_id: product.id, quantity: 1}}
    order_item = OrderItem.last

    assert_difference('OrderItem.count', -1) do
      delete order_item_path(order_item, format: :js)
    end
  end
end
