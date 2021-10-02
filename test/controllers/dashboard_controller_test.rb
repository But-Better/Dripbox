# frozen_string_literal: true

require 'test_helper'
include BCrypt

class DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    name = Faker::Name.name
    @password = '123456789asdfghxA'
    @mail = Faker::Internet.email
    @user = User.create(username: name, email: @mail, password: @password, email_confirmed: true,
                        confirm_token: nil, password_confirmation: @password)

    @test_resource = @user.user_resources.new(name: 'file', desc: 'eleven', tags: [Tag.create(name: 'Test')])
    @test_resource.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')
    @test_resource.save
  end

  def login
    post(login_url, params: { email: @user[:email], password: @password })
  end

  test 'should get index with login' do
    login
    get dashboard_url
    assert_response :success
  end

  test 'should get index but with argument' do
    login
    get dashboard_url(UserResource.first)
    assert_response :success
  end

  test 'should redirect on index with argument without login' do
    get dashboard_url(UserResource.first)
    assert_redirected_to login_url params: { locale: 'en' }
  end

  test 'redirect to login page if not logged in' do
    get dashboard_url
    assert_redirected_to login_url params: { locale: 'en' }
  end
end
