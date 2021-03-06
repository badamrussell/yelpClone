class BusinessFeature < ActiveRecord::Base
  attr_accessible :business_id, :feature_id, :value, :review_id

  validates :business_id, :feature_id, presence: true, numericality: true
  validates :review, presence: true
  validates :value, inclusion: {in: [true, false] }
  validates :feature_id, uniqueness: { scope: :review_id }

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id
  )

  belongs_to(
    :feature,
    class_name: "Feature",
    primary_key: :id,
    foreign_key: :feature_id
  )

  belongs_to(
    :review,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :review_id,
    inverse_of: :business_features
  )

  validates_presence_of :review

end
