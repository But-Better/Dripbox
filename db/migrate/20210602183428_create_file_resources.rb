class CreateFileResources < ActiveRecord::Migration[6.1]
  def change
    create_table :file_resources do |t|
      t.string :name
      t.string :url
      t.date :upload
      t.bigint :user_id
      t.text :desc

      t.timestamps
    end
  end
end
