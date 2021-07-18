# frozen_string_literal: true

require 'application_system_test_case'

class UserResourcesTest < ApplicationSystemTestCase
  setup do
    @user_resource = UserResource.create(name: "name1", desc: "desc1")
  end

  test 'visiting the index' do
    visit user_resource_index_url
    assert_selector 'h1', text: 'User Resources'
  end

  test 'creating a User resource' do
    visit user_resources_url
    click_on 'New User Resource'

    fill_in 'Desc', with: @user_resource.desc
    fill_in 'Name', with: @user_resource.name
    click_on 'Create User resource'

    assert_text 'User resource was successfully created'
    click_on 'Back'
  end

  test 'updating a User resource' do
    visit user_resources_url
    click_on 'Edit', match: :first

    fill_in 'Desc', with: @user_resource.desc
    fill_in 'Name', with: @user_resource.name
    click_on 'Update User resource'

    assert_text 'User resource was successfully updated'
    click_on 'Back'
  end

  test 'destroying a User resource' do
    visit user_resources_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'User resource was successfully destroyed'
  end
end
