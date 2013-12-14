class RestaurantDetail < ActiveRecord::Base
  attr_accessible :review_id, :good_for_groups_id, :noise_level_id, :price_range_id
  attr_accessible :attire_id, :good_for_kids_id, :wifi_id, :drive_thru_id, :has_tv_id, :caters_id
  attr_accessible :ambience_ids, :meal_ids

  validates :review, presence: true

  belongs_to(
    :review,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :review_id
  )

  belongs_to(
    :caters,
    class_name: "Decision",
    primary_key: :id,
    foreign_key: :caters_id
  )

  belongs_to(
    :price_range,
    class_name: "PriceRange",
    primary_key: :id,
    foreign_key: :price_range_id
  )

  belongs_to(
    :attire,
    class_name: "Attire",
    primary_key: :id,
    foreign_key: :attire_id
  )

  belongs_to(
    :good_for_groups,
    class_name: "Decision",
    primary_key: :id,
    foreign_key: :good_for_groups_id
  )

  belongs_to(
    :good_for_kids,
    class_name: "Decision",
    primary_key: :id,
    foreign_key: :good_for_kids_id
  )

  belongs_to(
    :drive_thru,
    class_name: "Decision",
    primary_key: :id,
    foreign_key: :drive_thru_id
  )

  belongs_to(
    :noise_level,
    class_name: "NoiseLevel",
    primary_key: :id,
    foreign_key: :noise_level_id
  )

  belongs_to(
    :has_tv,
    class_name: "Decision",
    primary_key: :id,
    foreign_key: :has_tv_id
  )

  belongs_to(
    :wifi,
    class_name: "Decision",
    primary_key: :id,
    foreign_key: :wifi_id
  )



  has_many(
    :ambience_reviews,
    class_name: "AmbienceReview",
    primary_key: :id,
    foreign_key: :restaurant_detail_id
  )

  has_many :ambience, through: :ambience_reviews, source: :ambience


  has_many(
    :meal_reviews,
    class_name: "GoodForMealReview",
    primary_key: :id,
    foreign_key: :restaurant_detail_id
  )

  has_many :meals, through: :meal_reviews, source: :meal


  def self.list
    list = [  { name: "", attribute_name: "good_for_groups_id" },
              { name: "", attribute_name: "noise_level_id" },
              { name: "", attribute_name: "price_range_id" },
              { name: "Attire", attribute_name: "attire_id" },
              { name: "Good For Kids", attribute_name: "good_for_kids_id" },
              { name: "WiFi", attribute_name: "wifi_id" },
              { name: "Drive Thru", attribute_name: "drive_thru_id" },
              { name: "Has TV", attribute_name: "has_tv_id" },
              { name: "Caters", attribute_name: "caters_id" }
            ]
  end

  def self.features
    [ { name: "Accepts Credit Cards", attribute_name: "" },
      { name: "BYOB", attribute_name: "" },
      { name: "Caters", attribute_name: "caters_id" },
      { name: "Corkage", attribute_name: "" },
      { name: "Delivery", attribute_name: "" },
      { name: "Dogs Allowed", attribute_name: "" },
      { name: "Good for Groups", attribute_name: "good_for_groups_id" },
      { name: "Good for Kids", attribute_name: "good_for_kids_id" },
      { name: "Has TV", attribute_name: "has_tv_id" },
      { name: "Open 24 Hours", attribute_name: "" },
      { name: "Order at Counter", attribute_name: "" },
      { name: "Outdoor Seating", attribute_name: "" },
      { name: "Take-out", attribute_name: "" },
      { name: "Takes Reservations", attribute_name: "" },
      { name: "Waiter Service", attribute_name: "" },
      { name: "Wheelchair Accessible", attribute_name: "" }
    ]
  end

end
