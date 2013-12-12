class Attire < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :review_details,
    class_name: "RestuarantDetail",
    primary_key: :id,
    foreign_key: :attire_id
  )

end
