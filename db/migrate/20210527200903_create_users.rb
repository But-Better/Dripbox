# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.boolean :email_confirmed, default: false
      t.string :confirm_token
      t.integer :login_counter, default: 0
      t.timestamps
    end
  end
end
