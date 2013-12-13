class Ambience < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :ambience_reviews,
    class_name: "AmbienceReview",
    primary_key: :id,
    foreign_key: :ambience_id
  )

end
