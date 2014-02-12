class ReviewVote < ActiveRecord::Base
  attr_accessible :review_id, :vote_id, :user_id

  validates :review_id, :vote_id, :user_id, presence: true
  validates :review_id, :vote_id, :user_id, numericality: true

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


  def self.toggle(user, review_id, vote_id)
    existingVote = ReviewVote.where(user_id: user.id, review_id: review_id, vote_id: vote_id)[0]
    
    action = 1
    
    if existingVote
      existingVote.destroy
      action = -1
    else
      existingVote = ReviewVote.create(user_id: user.id, vote_id: vote_id, review_id: review_id)
    end

    action
  end

end
