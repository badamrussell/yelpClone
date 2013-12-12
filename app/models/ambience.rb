class Ambience < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true


  has_many(
    :review_details,
    class_name: "RestaurantDetail",
    primary_key: :id,
    foreign_key: :ambience_id
  )

end
