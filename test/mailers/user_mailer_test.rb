# frozen_string_literal: true

require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'test_confirm_mail' do
    password = 'Admin123'
    username = '10Head'
    user = User.create(username: username, email: 'MailerMeister@5head.de', password: password,
                       password_confirmation: password)

    # Send the email, then test that it got queued
    email = UserMailer.registration_confirmation(user).deliver
    assert !ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal [user.email], email.to
    assert_equal 'Registration Confirmation', email.subject
    assert_match(/Hi #{user.username}/, email.encoded)
    assert_match(/Thanks for registering! To confirm your registration click the URL below./, email.encoded)
    assert_match(/#{user.confirm_token}/, email.encoded)
  end

  test 'Wrong (Password) Registration confirm mail' do
    password = 'admin123'
    username = '10Head'
    User.create(username: username, email: 'MailerMeister@5head.de', password: password,
                password_confirmation: password)

    assert_not !ActionMailer::Base.deliveries.empty?
  end

  test 'forgot password not found' do
    post password_reset_url, params: { email: 'Lol@gmx.de' }
    assert_equal('E-mail not found', flash[:alert])
  end
end
