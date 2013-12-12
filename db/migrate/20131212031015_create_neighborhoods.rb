class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :name, null: false
      t.integer :location_id, null: false

      t.timestamps
    end

    add_index :neighborhoods, :name, unique: true
    add_index :neighborhoods, :location_id
  end
end
