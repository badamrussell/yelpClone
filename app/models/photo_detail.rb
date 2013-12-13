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

  belongs_to(
    :helpful,
    class_name: "Helpful",
    primary_key: :id,
    foreign_key: :helpful_id
  )

end
