# frozen_string_literal: true

require 'test_helper'

class UserResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create username: 'name', email: 'note@mail.com', password_digest: 'abcdefg4'
    @user_resource = @user.user_resources.create id: 1, name: 'e', desc: 'EE'
  end

  test 'should get index' do
    get user_resources_url
    assert_equal 1, @user_resource.id
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
