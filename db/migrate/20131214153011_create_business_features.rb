class CreateBusinessFeatures < ActiveRecord::Migration
  def change
    create_table :business_features do |t|
      t.integer :business_id, null: false
      t.integer :feature_id, null: false
      t.boolean :value, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :business_features, :business_id
    add_index :business_features, :feature_id
    add_index :business_features, :user_id
  end
end
