class ReviewVote < ActiveRecord::Base
  attr_accessible :review_id, :vote_id, :user_id


  validates :review_id, :vote_id, :user_id, presence: true

  belongs_to(
    :review,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :review_id
  )

  belongs_to(
    :vote,
    class_name: "Vote",
    primary_key: :id,
    foreign_key: :vote_id
  )

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

end
