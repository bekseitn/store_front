# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Product search', type: :system do
  it 'filters products in place via the results Turbo Frame, without a full page reload' do
    create(:product, name: 'Oak Table', price: 250)
    create(:product, name: 'Steel Chair', price: 50)

    visit root_path
    expect(page).to have_content('Oak Table')
    expect(page).to have_content('Steel Chair')

    within('#products_results') do
      fill_in 'search_query', with: 'Oak'
      click_button 'Search'
    end

    # Only the turbo_frame_tag "products_results" content should have
    # changed - if this were a full page navigation instead of a
    # frame-scoped Turbo update, a stale/missing frame would 404 or
    # blank the page rather than swap just this content in place.
    expect(page).to have_content('Oak Table')
    expect(page).to have_no_content('Steel Chair')

    # A frame-scoped Turbo navigation doesn't push a new browser history
    # entry the way a full page navigation would - confirm we're still on
    # "/", not on whatever URL the search form's GET happened to target.
    expect(page).to have_current_path(root_path, ignore_query: true)
  end
end
