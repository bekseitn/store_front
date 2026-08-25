require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase
  test "create adds a real order item to the current order" do
    product = Product.create!(name: "Test chair", price: 50, active: true)

    assert_difference('OrderItem.count', 1) do
      post :create, order_item: { product_id: product.id, quantity: 3 }
    end

    order_item = OrderItem.last
    assert_equal product.id, order_item.product_id
    assert_equal 3, order_item.quantity
    assert_nil order_item.ordering_id
    assert_equal session[:order_id], order_item.order_id
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
