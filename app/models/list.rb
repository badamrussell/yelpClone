class List < ActiveRecord::Base
  attr_accessible :name, :desc, :user_id, :list_reviews_count

  validates :name, :user_id, presence: true
  validates :user_id, numericality: true

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many(
    :list_reviews,
    class_name: "ListReview",
    primary_key: :id,
    foreign_key: :list_id,
    include: :review
  )

  has_many :reviews, through: :list_reviews, source: :review


  def avatar
    reviews.first.avatar
  end
end
