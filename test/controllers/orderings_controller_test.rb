# frozen_string_literal: true

require 'test_helper'

class OrderingsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_ordering_path
    assert_response :success
  end

  test 'create finalizes the cart: moves items onto the ordering and empties the order' do
    product = Product.create!(name: 'Test chair', price: 100, active: true, category: categories(:one))
    order = Order.create!
    order_item = order.order_items.create!(product: product, quantity: 2)

    assert_difference('Ordering.count', 1) do
      post orderings_path, params: {ordering: {
        name: 'Jane Doe',
        address: '123 Main St',
        phone: '555-0100',
        order_id: order.id,
        city_id: cities(:one).id
      }}
    end

    assert_redirected_to root_path

    ordering = Ordering.last
    order_item.reload
    assert_equal ordering.id, order_item.ordering_id, 'item should be reassigned to the new ordering'
    assert_nil order_item.order_id, 'item should be detached from the order'
    assert_equal 200, ordering.total, "ordering should snapshot the order's total (2 x 100)"
    assert order.reload.order_items.empty?, 'order should read as an empty cart again'
  end
end
