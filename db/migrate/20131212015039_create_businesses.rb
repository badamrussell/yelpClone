class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.integer :country_id, null: false
      t.string :name, null: false
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :phone_number
      t.string :website
      t.float :rating
      t.integer :category1_id
      t.integer :category2_id
      t.integer :category3_id
      t.integer :neighborhood_id

      t.timestamps
    end

    add_index :businesses, :name
    add_index :businesses, :neighborhood_id
    add_index :businesses, :category1_id
    add_index :businesses, :category2_id
    add_index :businesses, :category3_id
  end
end
