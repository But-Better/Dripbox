# frozen_string_literal: true

require 'test_helper'

class HomePagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get login_url
    assert_response :success
  end
end
