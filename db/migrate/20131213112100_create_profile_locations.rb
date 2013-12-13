class CreateProfileLocations < ActiveRecord::Migration
  def change
    create_table :profile_locations do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.boolean :primary, default: false

      t.timestamps
    end

    add_index :profile_locations, :user_id
  end
end
