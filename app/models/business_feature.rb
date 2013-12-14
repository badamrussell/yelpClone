class BusinessFeature < ActiveRecord::Base
  attr_accessible :business_id, :feature_id, :value_id, :review_id

  validates presence: :business_id, :feature_id, :value_id, :review_id, presence: true

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
    :value,
    class_name: "FeatureValue",
    primary_key: :id,
    foreign_key: :value_id
  )

  belongs_to(
    :review,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :review_id
  )

end
