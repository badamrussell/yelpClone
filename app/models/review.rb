class Review < ActiveRecord::Base

  attr_accessible :rating, :user_id, :business_id, :body, :price_range, :feature_ids

  validates :rating, :user_id, :business, presence: true
  validates :body, presence: { message: "Review cannot be blank!" }
  validates :rating, numericality: { greater_than: 0 }
  validates :user_id, numericality: true

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id,
    counter_cache: true,
    include: :profile_locations
  )

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id,
    counter_cache: true,
    inverse_of: :reviews,
    touch: true,
    include: [:neighborhood, :photos]
  )

  # has_many :categories, through: :business, source: :categories

  has_many(
    :photos,
    class_name: "Photo",
    primary_key: :id,
    foreign_key: :review_id,
    dependent: :destroy
  )

  has_many(
    :business_features,
    class_name: "BusinessFeature",
    primary_key: :id,
    foreign_key: :review_id,
    inverse_of: :review,
    dependent: :destroy
  )

  has_many(
    :review_votes,
    class_name: "ReviewVote",
    primary_key: :id,
    foreign_key: :review_id,
    dependent: :destroy
  )

  has_many :votes, through: :review_votes, source: :vote

  has_many(
    :review_compliments,
    class_name: "ReviewCompliment",
    primary_key: :id,
    foreign_key: :review_id,
    include: [:user, :compliment],
    dependent: :destroy
  )

  has_many(
    :compliments,
    through: :review_compliments,
    source: :compliment
  )

  has_many(
    :list_reviews,
    class_name: "ListReview",
    primary_key: :id,
    foreign_key: :review_id,
    dependent: :destroy
  )

  has_many :lists, through: :list_review, source: :list

  

  def snippet(size = 60)
    if self.body.include?(".")
      self.body[0, self.body.index(".")]
    elsif self.body.length < size
      self.body
    else
      self.body[0...size] + "..."
    end
  end

  def completed_biz_features
    Hash[ business_features.map { |f| [f.feature_id, f.value] } ]
  end

  def self.recent(num)
    Review.limit(num).includes(:user, :business, :photos).order("reviews.updated_at DESC")
  end

  def rating_string
    "#{self.rating}0"
  end

  def user_avatar
    #USE DELEGATE?
    self.user.avatar
  end

  def business_avatar
    self.user.avatar
  end

  def as_json(options={})
    super(methods: [:user_avatar, :business_avatar], include: [:user])
  end
  
end
