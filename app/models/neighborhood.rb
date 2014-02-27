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
    Neighborhood.pluck(:id).first(20).shuffle[0]
  end

  def self.from_zip_code(zip_code)
    self.neighborhood_id = Neighborhood.random_neighborhood(1)
  end

end
