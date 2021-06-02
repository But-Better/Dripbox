class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :desc
      t.string :img_url

      t.timestamps
    end
  end
end
