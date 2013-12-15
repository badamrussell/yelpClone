class Vote < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :review_votes,
    class_name: "ReviewVote",
    primary_key: :id,
    foreign_key: :vote_id
  )

end
