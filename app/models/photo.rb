class Photo < ActiveRecord::Base
  attr_accessible :business_id, :img_url, :user_id, :review_id

  validates :img_url, :user_id, presence: true

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
    :photo_details,
    class_name: "PhotoDetail",
    primary_key: :id,
    foreign_key: :photo_id
  )

  belongs_to(
    :review,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :review_id
  )

  def is_store_front?
    business.store_front_id == self.id
  end

end
