# frozen_string_literal: true

class User < ApplicationRecord
  require 'uri'
  # has_secure_password

  has_many :user_resources

  validates :username,
            uniqueness: true,
            presence: true,
            length: { minimum: 2, maximum: 20 },
            allow_nil: false

end
