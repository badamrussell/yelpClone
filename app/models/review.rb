class Review < ActiveRecord::Base
  attr_accessible :rating, :user_id, :business_id, :body, :price_range, :feature_ids

  validates :rating, :user_id, :business_id, :body, presence: true

  before_destroy :destroy_features

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id
  )

  has_many(
    :business_features,
    through: :business,
    source: :business_features
  )

  has_many(
    :photos,
    class_name: "Photo",
    primary_key: :id,
    foreign_key: :review_id
  )

  has_many(
    :business_features,
    class_name: "BusinessFeature",
    primary_key: :id,
    foreign_key: :review_id,
    inverse_of: :review
  )

  has_many(
    :review_votes,
    class_name: "ReviewVote",
    primary_key: :id,
    foreign_key: :review_id
  )

  has_many :votes, through: :review_votes, source: :vote


  has_many(
    :vote_countA,
    class_name: "ReviewVote",
    primary_key: :id,
    foreign_key: :review_id,
    group: "review_votes.vote_id",
    select: "review_votes.vote_id AS id, COUNT(review_votes.id) AS count",
  )



  has_many(
    :review_compliments,
    class_name: "ReviewCompliment",
    primary_key: :id,
    foreign_key: :review_id
  )

  has_many :compliments, through: :review_compliments, source: :compliment

  has_many(
    :list_reviews,
    class_name: "ListReview",
    primary_key: :id,
    foreign_key: :review_id
  )

  has_many :lists, through: :list_review, source: :list

  def snippet(size = 60)

    if self.body.include?(".")
      self.body[0, self.body.index(".")]
    elsif self.body.length < size
      self.body[0..size]
    else
      self.body[0..size] + "..."
    end
  end

  def category_list
    ["food", "stuff"]
  end

  def destroy_features
    business_features.each do |bf|
      bf.destroy
    end
  end

  def completed_biz_features
    feat_hash = {}
    business_features.each do |f|
      feat_hash[f.feature_id] = f.value
    end

    feat_hash
  end

  has_many(
    :vote_count,
    through: :review_votes,
    source: :vote,
    group: "review_votes.vote_id",
    select: "review_votes.vote_id AS id, vote.name AS name, COUNT(review_votes.id) AS count",
  )

  def vote_count
    sql = <<-SQL
      SELECT votes.id AS id, votes.name AS name, COUNT(review_votes.vote_id) AS count
      FROM votes
      INNER JOIN review_votes ON votes.id = review_votes.vote_id
      WHERE review_votes.review_id = ?
      GROUP BY votes.id
    SQL

    result = Business.find_by_sql([sql, id])

    tallies = {}
    result.each { |r| tallies[r.id] = r.count }

    tallies
  end
end
