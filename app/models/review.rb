class Review < ActiveRecord::Base
  attr_accessible :rating, :user_id, :business_id, :body

  validates :rating, :user_id, :business_id, :body, presence: true

  has_one(
    :details,
    class_name: "RestaurantDetail",
    primary_key: :id,
    foreign_key: :review_id
  )

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
    :photos,
    class_name: "Photo",
    primary_key: :id,
    foreign_key: :photo_id
  )

  def snippet
    if self.body.include?(".")
      self.body[0, self.body.index(".")]
    else
      self.body[0..20]
    end
  end

  def category_list
    ["food", "stuff"]
  end

end
