# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :user_resources

  validates :name,
            uniqueness: true,
            presence: true,
            length: { minimum: 1, maximum: 30 },
            allow_nil: false,
            allow_blank: false
end
