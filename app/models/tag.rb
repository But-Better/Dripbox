# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :user_resources

  validates :name,
            uniqueness: true,
            presence: true,
            length: { minimum: 1, maximum: 10 },
            allow_nil: false,
            allow_blank: false

  def self.convert_string_to_tag(string)
    string = string.tr(" \t\r\n", '')
    local_tag = Tag.find_by(name: string)
    local_tag = Tag.create(name: string) if local_tag.nil?
    local_tag
  end
end
