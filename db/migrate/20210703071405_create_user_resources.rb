# frozen_string_literal: true

class CreateUserResources < ActiveRecord::Migration[6.1]
  def change
    create_table :user_resources do |t|
      t.string :name
      t.text :desc

      t.belongs_to :user

      t.timestamps
    end
  end
end
