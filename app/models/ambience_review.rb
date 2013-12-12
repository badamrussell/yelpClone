class AmbienceReview < ActiveRecord::Base
  attr_accessible :ambience_id, :restaurant_detail_id

  validates :ambience_id, :restaurant_detail_id, presence: true

  belongs_to(
    :ambience,
    class_name: "Ambience",
    primary_key: :id,
    foreign_key: :ambience_id
  )

  belongs_to(
    :restaurant_detail,
    class_name: "RestaurantDetail",
    primary_key: :id,
    foreign_key: :restaurant_detail_id
  )

end
