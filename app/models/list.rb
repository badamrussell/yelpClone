class List < ActiveRecord::Base
  attr_accessible :name, :user_id

  validates :name, :user_id, presence: true

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
    foreign_key: :list_id
  )

  has_many :reviews, through: :list_reviews, source: :review

end
