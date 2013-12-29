class PhotoDetail < ActiveRecord::Base
  attr_accessible :helpful_id, :photo_id, :store_front, :user_id

  validates :photo_id, :user_id, presence: true

  after_create { update_details(1) }
  after_destroy { update_details(-1) }
  after_update { update_details(0) }

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

  def update_details(increment)
    if store_front
      total = PhotoDetail.where(photo_id: photo_id, store_front: true).length + increment
      photo.update_attribute(:store_front_count, total)
    end
  end
end
