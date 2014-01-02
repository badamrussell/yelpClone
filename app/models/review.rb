class Review < ActiveRecord::Base
  attr_accessible :rating, :user_id, :business_id, :body, :price_range, :feature_ids

  validates :rating, :user_id, :business_id, :body, presence: true

  before_destroy :destroy_features
  after_create { update_data(1) }
  after_destroy { update_data(-1) }
  after_update { update_data(0) }

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id,
    counter_cache: true
  )

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id,
    counter_cache: true
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

  def update_data(increment)
    rating_total = 0
    rating_count = self.business.reviews_count + increment
    price_range_total = 0
    price_range_count = increment

    self.business.reviews.each do |rev|
      rating_total += rev.rating

      if rev.price_range > 0
        price_range_total += rev.price_range
        price_range_count += 1
      end
    end

    self.business.rating_avg = if rating_count > 0
      rating_total / (rating_count.to_f)
    else
      0
    end

    self.business.price_range_avg = if price_range_count > 0
      new_price = (price_range_total / price_range_count).round
      new_price == 0 ? 1 : new_price
    else
      0
    end

    self.business.save
  end



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

  def self.recent(num)
    Review.limit(num)
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

  def rating_string
    "#{self.rating}0"
  end

  def avatar
    self.user.avatar
  end

  def as_json(options={})
    puts "--------------------- TOP REVIEW AS JSON"
    super(methods: [:avatar], include: [:user])
  end

end
