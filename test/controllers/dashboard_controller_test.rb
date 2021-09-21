# frozen_string_literal: true

require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    password = "123456789asdfghxA"
    @user = User.create(username: 'note', email: 'note@mail.com', password: password, email_confirmed: true,
                        confirm_token: nil)
    @test_resource = @user.user_resources.create(name: 'file', desc: 'eleven', created_at: "2021-09-06 11:42:29.946328")
    @test_resource.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')
    @test_resource.save
  end

  def login
    post login_url params: { email: @user[:email], password: password }
  end

  test 'should get index' do
    login
    get dashboard_url
    assert_response :success
  end

  test 'with login doesnt redirect' do
    login
    get dashboard_url
  end

  test 'should get index but with argument' do
    login
    get dashboard_url(UserResource.first)
    assert_response :success
  end

  test 'redirect to login page if not logged in' do
    get dashboard_url
    assert_redirected_to login_url params: { locale: 'en' }
  end

end
