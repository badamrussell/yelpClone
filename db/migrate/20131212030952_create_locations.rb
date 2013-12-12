class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.integer :city_id, null: false

      t.timestamps
    end

    add_index :locations, :city_id
    add_index :locations, :name, unique: true
  end
end
