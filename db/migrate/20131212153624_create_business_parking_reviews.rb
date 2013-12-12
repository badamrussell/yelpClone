class CreateBusinessParkingReviews < ActiveRecord::Migration
  def change
    create_table :business_parking_reviews do |t|
      t.integer :business_parking_id
      t.integer :restaurant_detail_id

      t.timestamps
    end

    add_index :business_parking_reviews, :business_parking_id
    add_index :business_parking_reviews, :restaurant_detail_id
  end
end
