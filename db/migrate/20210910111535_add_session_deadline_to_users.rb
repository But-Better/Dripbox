class AddSessionDeadlineToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :deadline, :datetime, default: Time.now
  end
end
