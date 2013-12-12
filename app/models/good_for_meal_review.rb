class GoodForMealReview < ActiveRecord::Base
  attr_accessible :good_for_meal_id, :restaurant_detail_id

  validates :good_for_meal_id, :restaurant_detail_id, presence: true
end
