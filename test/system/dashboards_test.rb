# frozen_string_literal: true

require 'application_system_test_case'

class DashboardsTest < ApplicationSystemTestCase
  setup do
    @user_resource = UserResource.create(name: "name1", desc: "desc1")
  end

  setup do
    testUser1 = User.create(username: "testUsername")
    user1Data1 = testUser1.user_resources.new(name: "user1Data1",desc:"description11")
    user1Data2 = testUser1.user_resources.new(name: "user1Data2",desc:"description12")

    user1Data1.save
    user1Data2.save
  end


  test 'visiting the index of search results with search entry' do

    visit dashboard_url
    fill_in 'search_query', with: 'user1Data1\n'
    sleep 1


    visit searchresults_url
    sleep 5

  end
end
