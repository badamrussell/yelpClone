class GoodForMealReview < ActiveRecord::Base
  attr_accessible :good_for_meal_id, :restaurant_detail_id

  validates :good_for_meal_id, :restaurant_detail_id, presence: true

  belongs_to(
    :restaurant_details,
    class_name: "RestaurantDetail",
    primary_key: :id,
    foreign_key: :restaurant_detail_id
  )

  belongs_to(
    :restaurant_details,
    class_name: "RestaurantDetail",
    primary_key: :id,
    foreign_key: :ambience_id
  )

end
