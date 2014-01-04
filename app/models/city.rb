class City < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :areas,
    class_name: "Area",
    primary_key: :id,
    foreign_key: :area_id
  )

  has_many :neighborhoods, through: :areas, source: :neighborhoods

  @@Cities = City.all

  def self.preloaded
    @@Cities
  end
end
