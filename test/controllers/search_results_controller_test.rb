require "test_helper"

class SearchResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_results_index_url
    assert_response :success
  end

  setup do
    testUser1 = User.create(username: "testUsername")
    user1Data1 = testUser1.user_resources.new(name: "user1Data1",desc:"description11")
    user1Data2 = testUser1.user_resources.new(name: "user1Data2",desc:"description12")

    user1Data1.save
    user1Data2.save
  end

  test "open search result with entry from dashboard" do
    #seite wird geladen
    get dashboard_url
    assert_response :success

    post dashboard_path, params:

    fill_in
  end
end
