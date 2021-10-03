# frozen_string_literal: true

require 'application_system_test_case'

class SearchResultsTest < ApplicationSystemTestCase


  setup do
    @pw_u1 = '123456789asdfghxA'
    @email_u1 = Faker::Internet.email

    test_user1 = User.new(username: 'User1324z5', email: @email_u1, password: @pw_u1, email_confirmed: true,
                           confirm_token: nil)
    test_user1.save!

    testUser_1_resource_1 = test_user1.user_resources.new(name: 'User1_testResource1', desc: 'etwas user1 resc 1')
    testUser_1_resource_1.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'lost.jpg')
    testUser_1_resource_1.tags = [Tag.new(name: 'File')]
    testUser_1_resource_1.save
  end

  def login
    visit login_url
    fill_in 'floatingInput', with: @email_u1
    fill_in 'floatingPassword', with: @pw_u1
    click_button 'commit'
    sleep 2
  end

  test 'setup test' do

  end

  test 'visiting the index' do
    login
    visit '/searchresults?search_query='
    sleep 2
    assert_selector 'h1', text: 'Direkte Resources Suche'
  end

  test 'dashboard button redirects to dashboard' do
    login
    visit '/searchresults?search_query=test'
    sleep 2
    click_button('Dashboard')
    assert_selector 'h1', text: 'Dashboard'
  end

  test 'download link exists for found files' do
    login
    visit '/searchresults?search_query=User1_testResource1'
    sleep 2
    assert_selector 'a', text: 'lost.jpg'
  end

  test 'visit dashboard an look for file by filename' do
    search_term = 'User1'

    login
    fill_in 'search_query', with: search_term
    sleep 2
    click_button 'commit'
    sleep 2

    assert_selector 'a', text: 'lost.jpg'
  end

  test 'visit dashboard an look for file by tagname' do
    search_term = 'tag:File'

    login
    fill_in 'search_query', with: search_term
    sleep 2
    click_button 'commit'
    sleep 2

    assert_selector 'a', text: 'lost.jpg'
  end

  test 'visit dashboard an look for file by userName' do
    search_term = 'User1324z5'

    login
    fill_in 'search_query', with: search_term
    sleep 2
    click_button 'commit'
    sleep 2

    assert_selector 'a', text: 'lost.jpg'
  end

  test 'new dashboard Search Button' do
    login
    click_button 'commit'
    sleep 2

    assert_selector 'h1', text: 'Direkte Resources Suche'
  end
end
