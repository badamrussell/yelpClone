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

  def self.vote_count
    sql = <<-SQL
      SELECT review_votes.review_id AS review_id, votes.id AS id, votes.name AS name, COUNT(review_votes.vote_id) AS count
      FROM votes
      INNER JOIN review_votes ON votes.id = review_votes.vote_id
      GROUP BY review_id, votes.id
    SQL

    result = ReviewVote.find_by_sql(sql)

    tallies = {}
    result.each do |r|
      tallies[r.review_id] ||= {}
      tallies[r.review_id][r.id] = { name: r.name, count: r.count }
    end

    tallies
  end
end
