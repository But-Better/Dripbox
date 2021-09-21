# frozen_string_literal: true

class RoomMessage < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :message,
            presence: true,
            length: { minimum: 1, maximum: 500 }
end
