# frozen_string_literal: true

class UserResource < ApplicationRecord
  has_one_attached :file, service: :AzureStorage
  belongs_to :user

  validates_associated :tags

  validates :name,
            uniqueness: true,
            presence: true,
            length: { minimum: 2, maximum: 30},
            allow_nil: false,
            allow_blank: false

  validates :desc,
            uniqueness: false,
            presence: true,
            allow_nil: false

  has_and_belongs_to_many :tags
end
