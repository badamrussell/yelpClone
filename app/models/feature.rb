class Feature < ActiveRecord::Base
  attr_accessible :name, :feature_category_id

  validates :name, :feature_category_id, presence: true

  has_many(
    :business_features,
    class_name: "BusinessFeature",
    primary_key: :id,
    foreign_key: :feature_id
  )

  has_one(
    :category,
    class_name: "FeatureCategory",
    primary_key: :id,
    foreign_key: :feature_category_id
  )

  has_many :businesses, through: :business_features, source: :business

  def self.quick_all
    @features ||= Feature.all
  end
end
