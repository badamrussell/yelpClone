class City < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :areas,
    class_name: "Area",
    primary_key: :id,
    foreign_key: :city_id
  )

  has_many :neighborhoods, through: :areas, source: :neighborhoods

  def self.preloaded
    @all_cities = City.all
  end
end
