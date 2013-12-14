class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name, null: false
      t.integer :feature_category_id, default: 1

      t.timestamps
    end

    add_index :features, :feature_category_id
  end
end
