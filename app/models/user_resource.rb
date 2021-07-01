# frozen_string_literal: true

class UserResource < ApplicationRecord
  has_one_attached :file, service: :local
  belongs_to :user, foreign_key: true
  has_many :tags
end
