class CreateRestaurantDetails < ActiveRecord::Migration
  def change
    create_table :restaurant_details do |t|
      t.integer :review_id
      t.integer :good_for_groups

      t.integer :noise_level
      t.integer :price_range

      t.integer :attire
      t.integer :good_for_kids
      t.integer :wifi
      t.integer :drive_thru

      t.integer :has_tv
      t.integer :caters

      t.timestamps
    end
  end
end
