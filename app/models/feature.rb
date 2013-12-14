class Feature < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :business_features,
    class_name: "BusinessFeature",
    primary_key: :id,
    foreign_key: :feature_id
  )

  has_many :businesses, through: :business_features, source: :business
end
