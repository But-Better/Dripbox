# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  default from: 'dripbox.herokuapp.com'

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.username} <#{user.email}>", subject: 'Registration Confirmation')
  end
end
