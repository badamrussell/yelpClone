class GoodForMeal < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :meal_reviews,
    class_name: "GoodForMealReview",
    primary_key: :id,
    foreign_key: :good_for_meal_id
  )

end
