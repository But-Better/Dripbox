class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources do |t|
      t.string :name
      t.bigint :user_id
      t.date :uploaded_on
      t.text :desc

      t.timestamps
    end
  end
end
