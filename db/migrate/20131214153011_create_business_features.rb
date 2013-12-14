class CreateBusinessFeatures < ActiveRecord::Migration
  def change
    create_table :business_features do |t|
      t.integer :business_id, null: false
      t.integer :feature_id, null: false
      t.boolean :value_id, null: false
      t.integer :review_id, null: false

      t.timestamps
    end

    add_index :business_features, :business_id
    add_index :business_features, :feature_id
    add_index :business_features, :review_id
  end
end
