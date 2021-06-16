# frozen_string_literal: true

class User < ApplicationRecord
  before_create :confirmation_token

  has_secure_password
  require 'uri'

  before_save { self.email = email.downcase }

  validates :username,
            uniqueness: true,
            presence: true,
            length: { minimum: 2, maximum: 20 },
            allow_nil: false

  validates :email,
            uniqueness: true,
            presence: true,
            allow_nil: false,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  # https://stackoverflow.com/questions/5123972/ruby-on-rails-password-validation/33632569
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x

  validates :password_digest,
            presence: true,
            allow_nil: false,
            format: { with: PASSWORD_FORMAT },
            confirmation: true

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end
end
