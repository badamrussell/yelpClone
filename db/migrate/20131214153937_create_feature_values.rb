class CreateFeatureValues < ActiveRecord::Migration
  def change
    create_table :feature_values do |t|
      t.integer :feature_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :feature_values, [:feature_id, :name], unique: true
  end
end
