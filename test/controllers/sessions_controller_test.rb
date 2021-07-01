# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'Login' do
    password = 'Admin123'
    username = '10Head'
    user = User.create(username: username, email: 'Admin@5head.de', password: password, password_confirmation: password)

    post :"/login", params: { email: user[:email], password: user[password] }

    assert_not_equal session[:id], user[:id]
    assert_response :success
  end

  test 'Wrong Login' do
    password = 'Admin123'
    email = '10Head@bbg.com'

    post :"/login", params: { email: [email], password: [password] }

    assert_not_equal session[:id], user[:id]
    assert_response :success
  end
end
