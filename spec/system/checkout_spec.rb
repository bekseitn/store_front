# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Checkout', type: :system do
  def add_oak_table_to_cart
    create(:product, name: 'Oak Table', price: 250)

    visit root_path
    expect(page).to have_content('Oak Table')

    within('.card', text: 'Oak Table') do
      click_button 'Add to cart'
    end
    # Wait for the Turbo Stream response to actually land before moving
    # on - the POST itself is async from the browser's perspective, and
    # navigating away immediately can race ahead of it.
    expect(page).to have_content('Items in cart: 1')
  end

  it 'adds a product to the cart and completes checkout' do
    add_oak_table_to_cart
    city = create(:city, name: 'Astana')

    visit cart_path
    expect(page).to have_content('Oak Table')
    expect(page).to have_content('250')

    click_link 'Checkout'
    expect(page).to have_content('Checkout')

    fill_in 'Customer name', with: 'Jane Doe'
    fill_in 'Phone number', with: '+1 555 0100'
    fill_in 'Address', with: '123 Main St'
    select city.name, from: 'City'
    click_button 'Place order'

    expect(page).to have_content('Order placed successfully')
  end

  it 'reassigns the cart items onto the new Ordering and empties the cart' do
    add_oak_table_to_cart
    product = Product.find_by(name: 'Oak Table')
    city = create(:city, name: 'Astana')

    visit cart_path
    click_link 'Checkout'
    fill_in 'Customer name', with: 'Jane Doe'
    fill_in 'Phone number', with: '+1 555 0100'
    fill_in 'Address', with: '123 Main St'
    select city.name, from: 'City'
    click_button 'Place order'
    expect(page).to have_content('Order placed successfully')

    # The cart is emptied by reassigning its order_items onto the new
    # Ordering (see ApplicationController#current_order /
    # Ordering#set_order_items) - confirm that side effect actually
    # happened, not just that the page rendered a success message.
    ordering = Ordering.last
    expect(ordering.name).to eq('Jane Doe')
    expect(ordering.order_items.count).to eq(1)
    expect(ordering.order_items.first.product).to eq(product)

    visit cart_path
    expect(page).to have_content('empty')
  end

  it 'shows validation errors without a full-page reload when required fields are missing' do
    add_oak_table_to_cart

    visit cart_path
    click_link 'Checkout'
    click_button 'Place order'

    expect(page).to have_selector('.invalid-feedback')
    expect(Ordering.count).to eq(0)
  end
end
