class CreateFeatureValues < ActiveRecord::Migration
  def change
    create_table :feature_values do |t|
      t.string :name
      t.integer :feature_id

      t.timestamps
    end
  end
end
