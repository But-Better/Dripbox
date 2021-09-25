# frozen_string_literal: true

require 'application_system_test_case'

class DashboardsTest < ApplicationSystemTestCase
  setup do
    @password = '123456789asdfghxA'
    @user = User.create(username: 'note', email: 'note@mail.com', password: @password, email_confirmed: true,
                        confirm_token: nil)
  end

  def add_user_resource
    @test_resource = @user.user_resources.create(name: 'file', desc: 'eleven', created_at: '2021-09-06 11:42:29.946328')
    @test_resource.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')
    @test_resource.save
  end

  def login_before
    visit login_url
    fill_in 'floatingInput', with: @user.email
    fill_in 'floatingPassword', with: @password
    click_button 'commit'
    sleep 1
  end

  test 'login and go to dashboard' do
    add_user_resource
    login_before
    visit dashboard_url
    assert_selector 'h1', text: 'Dashboard'
    assert_selector 'tspan', class: 'mg-chart-title', text: 'Upload History Graph'
    assert_selector 'tspan', class: 'mg-chart-title', text: 'Types of Files'
    assert_selector 'tspan', class: 'mg-chart-title', text: 'Top 5 Files in Terms of Size'
  end

  test 'login got to dashboard but no user_resources were created' do
    login_before
    visit dashboard_url
    assert_selector 'h1', text: 'Dashboard'
    assert_selector 'text', class: 'mg-missing-text', text: 'No Data for this Statistic given yet'
  end

  test 'go to dashboard without login' do
    visit dashboard_url
    assert_selector 'h2', text: 'Please sign in'
  end

  test 'preview item' do
    @test_resource = @user.user_resources.create(name: 'file', desc: 'eleven', created_at: '2021-09-06 11:42:29.946328')
    @test_resource.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')
    @test_resource.save

    visit login_url
    fill_in 'floatingInput', with: @user.email
    fill_in 'floatingPassword', with: @password
    click_button 'commit'
  end
end
