require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get registrations_index_url
    assert_response :success
  end
end
