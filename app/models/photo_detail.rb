class PhotoDetail < ActiveRecord::Base
  attr_accessible :helpful_id, :photo_id, :store_front, :user_id

  validates :photo_id, :user_id, presence: true

  belongs_to(
    :photo,
    class_name: "Photo",
    primary_key: :id,
    foreign_key: :photo_id
  )

  belongs_to(
    :user,
    class_name: "user",
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many(
    :photo_details,
    class_name: "PhotoDetail",
    primary_key: :id,
    foreign_key: :photo_id
  )

end
