# frozen_string_literal: true

require 'application_system_test_case'

class DashboardsTest < ApplicationSystemTestCase
  setup do
    @password = "123456789asdfghxA"
    @user = User.create(username: 'note', email: 'note@mail.com', password: @password, email_confirmed: true,
                        confirm_token: nil)
    @test_resource = @user.user_resources.create(name: 'file', desc: 'eleven', created_at: "2021-09-06 11:42:29.946328")
    @test_resource.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')
    @test_resource.save
  end

  test 'visiting the index of search results with search entry' do
    visit login_url
    fill_in 'floatingInput', with: @user.email
    fill_in 'floatingPassword', with: @password
    click_button 'commit'
    sleep 1
    assert_selector "h1", text: "Dashboard"
  end
end
