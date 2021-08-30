# frozen_string_literal: true

class TagsUserResources < ActiveRecord::Migration[6.1]
  def change
    create_join_table :user_resources, :tags
  end
end
