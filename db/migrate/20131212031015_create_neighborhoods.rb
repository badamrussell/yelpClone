class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :name, null: false
      t.integer :area_id, null: false

      t.timestamps
    end

    add_index :neighborhoods, [:name, :area_id], unique: true
  end
end
