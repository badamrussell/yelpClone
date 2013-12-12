class GoodForMeal < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :restaurant_details,
    class_name: "RestaurantDetail",
    primary_key: :id,
    foreign_key: :good_for_meal_id
  )

end
