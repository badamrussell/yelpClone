class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :city_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :areas, :city_id
  end
end
