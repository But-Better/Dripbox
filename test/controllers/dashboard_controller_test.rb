# frozen_string_literal: true

require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get dashboard_url
    assert_response :success
  end

  test 'should get index but with argument' do
    get dashboard_url(FileResource.first)
    assert_response :success
  end
end
