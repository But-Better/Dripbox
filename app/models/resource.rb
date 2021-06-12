class Resource < ApplicationRecord
  has_one_attached :file

  def to_array
    [id, name, upload, user_id, desc]
  end
end
