class FeatureValues < ActiveRecord::Base
  attr_accessible :feature_id, :name

  validates :feature_id, :name, presence: true

  has_many(
    :features,
    class_name: "Feature",
    primary_key: :id,
    foreign_key: :feature_id
  )

end
