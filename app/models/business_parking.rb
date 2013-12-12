class BusinessParking < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :restaurant_details,
    class_name: "RestaurantDetail",
    primary_key: :id,
    foreign_key: :business_parking_id
  )

end
