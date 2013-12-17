class Area < ActiveRecord::Base
  attr_accessible :city_id, :name

  validates :city_id, :name, presence: true

  belongs_to(
    :city,
    class_name: "City",
    primary_key: :id,
    foreign_key: :city_id
  )

  has_many(
    :neighborhoods,
    class_name: "Neighborhood",
    primary_key: :id,
    foreign_key: :area_id
  )

  def self.determine_neighborhood()
    "Manhattan, NY"
  end

  def self.random_ny_gps
    "40.#{rand(100000)},-73.#{rand(100000)}"
  end

end
