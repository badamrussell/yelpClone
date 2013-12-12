class Review < ActiveRecord::Base
  attr_accessible :rating, :user_id, :business_id, :body

  validates :rating, :user_id, :business_id, :body, presence: true

  has_one(
    :restaurant_details,
    class_name: "RestaurantDetail",
    primary_key: :id,
    foreign_key: :review_id
  )

  belongs_to(
    :user,
    class_name: "user",
    primary_key: :id,
    foreign_key: :user_id
  )

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id
  )

end
