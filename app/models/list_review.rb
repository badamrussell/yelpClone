class ListReview < ActiveRecord::Base
  attr_accessible :list_id, :review_id

  validates :list_id, :review_id, presence: true

  belongs_to(
    :list,
    class_name: "List",
    primary_key: :id,
    foreign_key: :list_id,
    counter_cache: true
  )

  belongs_to(
    :review,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :review_id,
    include: :business
  )

end
