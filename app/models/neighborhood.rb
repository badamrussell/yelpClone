class Neighborhood < ActiveRecord::Base
  attr_accessible :location_id, :name

  validates :location_id, :name, presence: true

  belongs_to(
    :location,
    class_name: "Location",
    primary_key: :id,
    foreign_key: :location_id
  )


end
