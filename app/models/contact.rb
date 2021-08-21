class Contact < ApplicationRecord

  require 'uri'

  validates :name,
            length: { minimum: 2, maximum: 30 }

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :message,
            length: {minimum: 1, maximum: 8192}


end
