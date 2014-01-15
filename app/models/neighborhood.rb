class Neighborhood < ActiveRecord::Base
  attr_accessible :area_id, :name

  validates :area_id, :name, presence: true
  validates :area_id, numericality: true

  belongs_to(
    :area,
    class_name: "Area",
    primary_key: :id,
    foreign_key: :area_id
  )

  has_many(
    :businesses,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :neighborhood_id
  )

  def self.random_neighborhood(city_id)
    rand(1..20)
  end
end
