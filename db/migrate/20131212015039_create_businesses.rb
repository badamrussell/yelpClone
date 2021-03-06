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
      t.float :rating_avg, default: 0
      t.integer :price_range_avg, default: 0
      t.integer :store_front_id
      t.integer :reviews_count, default: 0
      t.integer :photos_count, default: 0
      t.integer :neighborhood_id

      t.timestamps
    end

    add_index :businesses, :name
    add_index :businesses, :neighborhood_id
  end
end
