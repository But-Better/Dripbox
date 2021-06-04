class User < ApplicationRecord

  validates :username,
            uniqueness: true,
            presence: true,
            length: { minimum: 2, maximum: 20 }

  validates :email,
            uniqueness: true,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  #https://stackoverflow.com/questions/5123972/ruby-on-rails-password-validation/33632569
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x

  validates :password_digest,
            presence: true,
            length: {minimum: 8, maximum: 256 },
            on: :create,
            format: { with: PASSWORD_FORMAT }
end