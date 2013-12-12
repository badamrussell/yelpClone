class NoiseLevel < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :restaurant_details,
    class_name: "RestaurantDetail",
    primary_key: :id,
    foreign_key: :noise_level_id
  )

end
