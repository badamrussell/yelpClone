class CreateRestaurantDetails < ActiveRecord::Migration
  def change
    create_table :restaurant_details do |t|
      t.integer :review_id
      t.integer :good_for_groups_id

      t.integer :noise_level_id
      t.integer :price_range_id

      t.integer :attire_id
      t.integer :good_for_kids_id
      t.integer :wifi_id
      t.integer :drive_thru_id

      t.integer :has_tv_id
      t.integer :caters_id

      t.timestamps
    end
  end
end
