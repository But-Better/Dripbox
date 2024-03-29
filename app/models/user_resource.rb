# frozen_string_literal: true

class UserResource < ApplicationRecord
  has_and_belongs_to_many :tags
  has_one_attached :file
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
    res = []
    if params.include? "tag:"
      params.slice! "tag:"
      res = find_by_t(params)
    else
      params = params.downcase
      res = joins(:user).where('LOWER(name) LIKE :lookUp OR LOWER(username) LIKE :lookUp', lookUp: "%#{params}%")
    end
    res
  end

  def self.find_by_t(name)
    tags = Tag.find_by_name(name)
    tags.user_resources
  end

  def byte_filesize
    file.record.file_blob.attachable_filesize
  end

  def type
    file.content_type
  end

  def creation_date
    created_at.to_date
  end

  def update_tags(string)
    string_split = string.split(',')
    new_tags = []
    string_split.each do |tag|
      new_tags.append Tag.convert_string_to_tag(tag)
    end

    union_result = tags - new_tags

    tags.delete(union_result) if union_result

    union_result = new_tags - tags

    tags.append union_result
  end

  def tags_to_s
    printable_string = ''
    tags.each do |tag|
      printable_string += "#{tag.name}, "
    end
    printable_string[0...-2]
  end
end
