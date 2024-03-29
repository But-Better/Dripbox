# frozen_string_literal: true

class AddContactableToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :contact_status, :boolean, default: false
  end
end
