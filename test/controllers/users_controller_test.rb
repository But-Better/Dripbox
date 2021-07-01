# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'Create default User' do
    password = 'Admin123'
    username = '10Head'
    user = User.create(username: username, email: 'Kevin@5head.de', password: password, password_confirmation: password)
    assert user.valid?
  end

  test 'Create User with Wrong username' do
    password = 'Admin123'
    username = '1'
    user = User.create(username: username, email: 'Kevin@5head.de', password: password, password_confirmation: password)
    assert_not user.valid?
  end

  test 'Create User with Wrong Email' do
    password = 'Admin123'
    username = 'JBO'
    email = 'MonkaS'
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    assert_not user.valid?
  end

  test 'Create USer with Wrong Password' do
    password = 'admin123'
    username = 'Meister'
    email = 'JoMeister@5head.de'
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    assert_not user.valid?
  end

  test 'Created user Password_Digest != enter password' do
    password = 'Admin123'
    username = 'MeisterProper'
    email = 'NeinMajoIstKein@5head.de'
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    assert_not_equal password, user.password_digest
  end

  test 'Create user and confirm_email' do
    password = 'Admin123'
    username = 'Volibär'
    email = 'ShowMeWhatYourGone@5head.de'
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    assert_not_nil user.confirm_token
  end

  test 'Create wrong user and confirm_email is nil' do
    password = 'admin123'
    username = 'Volibär'
    email = 'ShowMeWhatYourGone@5head.de'
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    assert_nil user.confirm_token
  end

  test "Create user and throw Password isn't equal" do
    password = 'admin123'
    username = 'Ingrid'
    email = 'IndeedNotIngrid@5head.de'
    user = User.create(username: username, email: email, password: password, password_confirmation: "#{password}123")
    assert_not user.valid?
  end
end
