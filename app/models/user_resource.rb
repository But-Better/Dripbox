# frozen_string_literal: true

class UserResource < ApplicationRecord
  has_and_belongs_to_many :tags
  has_one_attached :file, service: :local
  belongs_to :user

  validates_associated :tags

  validates :name,
            uniqueness: true,
            presence: true,
            length: { minimum: 2, maximum: 30 },
            allow_nil: false,
            allow_blank: false

  validates :desc,
            uniqueness: false,
            presence: true,
            allow_nil: false

  validates :file,
            presence: true

  # such in dem namen des files und usernamen nach einer nicht leeren eingabe
  def self.search(params)
    # desc vom typ text!
    params = params.downcase
    joins(:user).where('LOWER(name) LIKE :lookUp OR LOWER(username) LIKE :lookUp', lookUp: "%#{params}%")
  end

  def byte_filesize
    file.record.file_blob.attachable_filesize
  end

  def type
    self.file.content_type
  end

  def creation_date
    created_at.to_date
  end
end
