# frozen_string_literal: true

require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_password_reset_url
    assert_response :success
  end

  test 'Reset Password deliver email' do
    password = 'Admin123'
    username = '10Head'
    user = User.create(username: username, email: 'Admin@5head.de', password: password, password_confirmation: password)

    post '/password_resets', params: { email: user.email }
    email = UserMailer.forgot_password(user).deliver
    assert !ActionMailer::Base.deliveries.empty?
  end
end
