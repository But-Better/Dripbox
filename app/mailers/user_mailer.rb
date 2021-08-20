# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  default from: 'dripbox@herokuapp.com'

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.username} <#{user.email}>", subject: 'Registration Confirmation')
  end

  def forgot_password(user)
    @user = user
    @greeting = 'Hi'

    mail to: user.email, subject: 'Reset password instructions'
  end
end
