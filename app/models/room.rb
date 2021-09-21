# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :room_messages

  validates :name,
            uniqueness: true,
            presence: true,
            length: { minimum: 1, maximum: 20 }
end
