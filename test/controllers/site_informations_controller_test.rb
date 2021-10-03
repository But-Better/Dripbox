# frozen_string_literal: true

require 'test_helper'

class SiteInformationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get agb' do
    get agb_path
    assert_response :success
  end

  test 'should get datenschutz' do
    get datenschutz_path
    assert_response :success
  end

  test 'should get about' do
    get uber_path
    assert_response :success
  end
end
