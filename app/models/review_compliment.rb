class ReviewCompliment < ActiveRecord::Base
  attr_accessible :body, :compliment_id, :review_id, :user_id

  validates :compliment_id, :review_id, :user_id, presence: true

  belongs_to(
    :compliment,
    class_name: "Compliment",
    primary_key: :id,
    foreign_key: :compliment_id
  )

  belongs_to(
    :review,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :review_id,
    include: [:user, :business]
  )

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id,
    counter_cache: true,
    include: [:photos, :profile_locations]
  )
end
