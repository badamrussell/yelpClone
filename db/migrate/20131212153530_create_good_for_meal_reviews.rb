class CreateGoodForMealReviews < ActiveRecord::Migration
  def change
    create_table :good_for_meal_reviews do |t|
      t.integer :good_for_meal_id
      t.integer :restaurant_detail_id

      t.timestamps
    end

    add_index :good_for_meal_reviews, :good_for_meal_id
    add_index :good_for_meal_reviews, :restaurant_detail_id
  end
end
