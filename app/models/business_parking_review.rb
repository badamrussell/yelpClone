class BusinessParkingReview < ActiveRecord::Base
  attr_accessible :business_parking_id, :restaurant_detail_id

  validates :business_parking_id, :restaurant_detail_id, presence: true

  belongs_to(
    :business_parking,
    class_name: "ReviewDetail",
    primary_key: :id,
    foreign_key: :business_parking_id
  )

  belongs_to(
    :restaurant_detail,
    class_name: "RestaurantDetail",
    primary_key: :id,
    foreign_key: :restaurant_detail_id
  )


end
