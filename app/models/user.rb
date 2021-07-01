# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  before_create :confirmation_token

  require 'uri'
  validates_uniqueness_of :email

  before_save do
    self.email = email.downcase
  end

  validates :username,
            uniqueness: true,
            presence: true,
            length: { minimum: 2, maximum: 20 }

  validates :email,
            uniqueness: { case_sensitive: false },
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  # https://stackoverflow.com/questions/5123972/ruby-on-rails-password-validation/33632569
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower cas e character
  (?=.*[A-Z])        # Must contain an upper case character
/x

  validates :password,
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
    save!
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    UserMailer.forgot_password(self).deliver # This sends an e-mail with a link for the user to reset the password
    save!
  end

  # This generates a random password reset token for the user
  def generate_token(column)
    loop do
      self[column] = SecureRandom.urlsafe_base64
      break unless User.exists?(column => self[column])
    end
  end
end
