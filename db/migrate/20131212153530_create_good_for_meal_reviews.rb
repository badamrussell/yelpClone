class CreateGoodForMealReviews < ActiveRecord::Migration
  def change
    create_table :good_for_meal_reviews do |t|

      t.timestamps
    end
  end
end
