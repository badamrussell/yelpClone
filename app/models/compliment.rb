class Compliment < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :review_compliments,
    class_name: "ReviewCompliment",
    primary_key: :id,
    foreign_key: :compliment_id
  )

  has_many :compliments, through: :review_compliments, source: :compliment

end