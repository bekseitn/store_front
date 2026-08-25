# frozen_string_literal: true

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get category_path(categories(:one))
    assert_response :success
  end
end
