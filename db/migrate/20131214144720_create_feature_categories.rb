class CreateFeatureCategories < ActiveRecord::Migration
  def change
    create_table :feature_categories do |t|
      t.string :name, null: false
      t.integer :input_type, default: 1

      t.timestamps
    end
  end
end
