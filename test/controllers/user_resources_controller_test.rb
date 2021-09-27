# frozen_string_literal: true

require 'test_helper'

class UserResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    #noinspection SpellCheckingInspection
    password = '123456789asdfghxA'

    user = User.create(username: Faker::Name.name, email: Faker::Internet.email, password: password, email_confirmed: true,
                        confirm_token: nil, password_confirmation: password)
    @test_resource = user.user_resources.new(name: 'file', desc: 'eleven', created_at: '2021-09-06 11:42:29.946328')
    @test_resource.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')
    @test_resource.save

    post login_path, params: { email: user[:email], password: password }
  end

  test 'should get index' do
    get user_resources_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_resource_url
    assert_response :success
  end

  test 'should create user_resource' do
    assert_difference('UserResource.count') do
      post user_resources_url, params: { user_resource: { desc: 'and there is some good text here', name: 'another', tags: 'this, that, and more' } }
    end

    assert_redirected_to UserResource.last, params: { locale: 'en' }
  end

  test 'should show user_resource' do
    get user_resources_url
    assert([@test_resource], @user_resources)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_resource_url(id: @test_resource.id)
    assert_response :success
  end

  test 'should update user_resource' do
    patch user_resource_url @test_resource,
                            params: { user_resource: { desc: @test_resource.desc, name: @test_resource.name } }
    assert_redirected_to @test_resource, params: { locale: 'en' }
  end

  test 'should destroy user_resource' do
    assert_difference('UserResource.count', -1) do
      delete user_resource_url(@test_resource)
    end

    assert_redirected_to user_resources_url params: { locale: 'en' }
  end
end
