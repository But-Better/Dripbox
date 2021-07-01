# frozen_string_literal: true

require 'test_helper'
class UserMailerTest < ActionMailer::TestCase

  def test_confirm_mail
    password = 'Admin123'
    username = '10Head'
    user = User.create(username: username, email: 'MailerMeister@5head.de', password: password, password_confirmation: password)

    # Send the email, then test that it got queued
    email = UserMailer.registration_confirmation(user).deliver
    assert !ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal [user.email], email.to
    assert_equal "Registration Confirmation", email.subject
    assert_match(/Hi #{user.username}/, email.encoded)
    assert_match(/Thanks for registering! To confirm your registration click the URL below./, email.encoded)
    assert_match(/#{user.confirm_token}/, email.encoded)
  end

end
