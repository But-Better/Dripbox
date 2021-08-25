# frozen_string_literal: true

require 'application_system_test_case'

class SearchResultsTest < ApplicationSystemTestCase
  setup do
    testUser_1 = User.create(username: 'testUserName_1')
    testUser_1_resource_1 = testUser_1.user_resources.new(name: 'User1_testResource1', desc: 'etwas user1 resc 1')
    testUser_1_resource_1.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'lost.jpg')
    testUser_1_resource_1.tags = [Tag.new(name: 'File')]
    testUser_1_resource_1.save
  end

  test 'visiting the index' do
    visit '/searchresults?search_query='
    assert_selector 'h1', text: 'Direkte Resources Suche'
  end

  test 'dashboard button redirects to dashboard' do
    visit '/searchresults?search_query=test'
    click_button('Dashboard')
    assert_current_path(dashboard_url)
  end

  test 'download link redirects to download' do
    visit '/searchresults?search_query=User1_testResource1'
    click_link('lost.jpg')
    assert_current_path('%/rails/active_storage/blobs/redirect/%/lost.jpg?disposition=attachment')
  end
end
