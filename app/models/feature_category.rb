class FeatureCategory < ActiveRecord::Base
  attr_accessible :name, :input_type

  validates :name, :input_type, presence: true

  has_many(
    :features,
    class_name: "Feature",
    primary_key: :id,
    foreign_key: :feature_category_id
  )

  BOOLCHOICE = Struct.new(:id, :name)

  def self.basic_choice
    [BOOLCHOICE.new(1, "Yes"), BOOLCHOICE.new(0, "No")]
  end
end
