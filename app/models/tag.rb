# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :user_resources

  validates :name,
            uniqueness: true,
            presence: true,
            length: { minimum: 1, maximum: 10 },
            allow_nil: false,
            allow_blank: false

  def save_with_name_to(name, user_resource)
    local_tag = Tags.find_by(name: name)
    local_tag = Tags.create(name: name) if local_tag.nil?
    user_resource.tags.append(local_tag)
  end
end
