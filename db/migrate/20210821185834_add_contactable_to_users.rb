class AddContactEnumToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :contact_status, :boolean, default: false
  end
end
