# frozen_string_literal: true

class UserResource < ApplicationRecord
  has_one_attached :file, service: :local
  belongs_to :user
  has_and_belongs_to_many :tags

  #such in dem namen des files und usernamen nach einer nicht leeren eingabe
  def self.search(params)
    #desc vom typ text!
    params = params.downcase
    joins(:user).where("LOWER(name) LIKE :lookUp OR LOWER(username) LIKE :lookUp", lookUp:"%#{params}%")
  end
end



