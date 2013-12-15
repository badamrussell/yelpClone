class Review < ActiveRecord::Base
  attr_accessible :rating, :user_id, :business_id, :body, :feature_ids

  validates :rating, :user_id, :business_id, :body, presence: true

  before_destroy :destroy_features

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id
  )

  has_many(
    :business_features,
    through: :business,
    source: :business_features
  )

  has_many(
    :photos,
    class_name: "Photo",
    primary_key: :id,
    foreign_key: :review_id
  )

  def snippet(size = 60)

    if self.body.include?(".")
      self.body[0, self.body.index(".")]
    elsif self.body.length < size
      self.body[0..size]
    else
      self.body[0..size] + "..."
    end
  end

  def category_list
    ["food", "stuff"]
  end

  def destroy_features
    business_features.each do |bf|
      bf.destroy
    end
  end
end
