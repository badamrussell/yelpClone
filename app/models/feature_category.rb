class FeatureCategory < ActiveRecord::Base
  attr_accessible :name, :input_type

  validates :name, :input_type, presence: true

  has_many(
    :features,
    class_name: "Feature",
    primary_key: :id,
    foreign_key: :feature_category_id
  )
  @BoolChoice = Struct.new(:id, :name)

  def self.feature_list
    feats = Feature.all.map { |f| feats if f.feature_category_id == 1 }

    self.all.each do |fc|
      next if fc.id == 1
      feats << fc
    end

    feats
  end

  def self.basic_choice
    [@BoolChoice.new(1, "Yes"), @BoolChoice.new(0, "No")]
  end
end
