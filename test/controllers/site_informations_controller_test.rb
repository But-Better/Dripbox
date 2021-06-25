# frozen_string_literal: true

require 'test_helper'

class SiteInformationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get agb' do
    get site_informations_agb_url
    assert_response :success
  end

  test 'should get datenschutz' do
    get site_informations_datenschutz_url
    assert_response :success
  end
end
