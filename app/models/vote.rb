class Vote < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :review_votes,
    class_name: "ReviewVote",
    primary_key: :id,
    foreign_key: :vote_id
  )


  def self.all_cached
  	# @all_votes ||= Vote.all
    Vote.all
  end


  def self.vote_counts
  	@vote_counts = Vote.joins(:review_votes).group(:review_id, "votes.id").count(:vote_id)
  end


end
