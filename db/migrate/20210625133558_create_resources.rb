# frozen_string_literal: true

class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources do |t|
      t.string :name
      t.text :desc
      t.references :user
      t.references :category
      t.date :upload
      t.timestamps
    end
  end
end
