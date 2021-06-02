class CreateFileResourceCategoryRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :file_resource_category_relation do |t|
      t.bigint :file_resource_id
      t.bigint :category_id

      t.timestamps
    end
  end
end
