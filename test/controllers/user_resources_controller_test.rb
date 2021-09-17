# frozen_string_literal: true

require 'test_helper'
require 'rails-controller-testing'
Rails::Controller::Testing.install

class UserResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: 'note', email: 'note@mail.com', password: '123456789asdfghxA', email_confirmed: true,
                        confirm_token: nil)
    @user_resource = @user.user_resources.create(name: 'file', desc: 'eleven', created_at: "2021-09-06 11:42:29.946328")
    @user_resource.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')
    @user_resource.save
  end

  test 'should get index' do
    get registrations_index_path
    assert_equal 0, assigns(@something)
    assert_response :success
  end

  test 'should get new' do
    get new_user_resource_url
    assert_response :success
  end

  test 'should create user_resource' do
    assert_difference('UserResource.count') do
      post user_resources_url, params: { user_resource: { desc: @user_resource.desc, name: @user_resource.name } }
    end

    assert_redirected_to dashboard_url(UserResource.last)
  end

  test 'should show user_resource' do
    get user_resources_url
    assert_not_empty @user_resources
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_resource_url(id: @user_resource.id)
    assert_response :success
  end

  test 'should update user_resource' do
    patch user_resource_url @user_resource,
                            params: { user_resource: { desc: @user_resource.desc, name: @user_resource.name } }
    assert_redirected_to dashboard_url(@user_resource)
  end

  test 'should destroy user_resource' do
    assert_difference('UserResource.count', -1) do
      delete user_resource_url(@user_resource)
    end

    assert_redirected_to user_resources_url
  end
end
