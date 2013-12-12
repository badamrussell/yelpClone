class City < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :locations,
    class_name: "Location",
    primary_key: :id,
    foreign_key: :city_id
  )

  has_many :neighborhoods, through: :locations, source: :neighborhoods

end
