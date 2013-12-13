class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :main_category_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :categories, :main_category_id
  end
end
