class PhotoDetail < ActiveRecord::Base
  attr_accessible :helpful_id, :photo_id, :store_front, :user_id

  validates :photo_id, :user_id, presence: true
  validates :user_id, uniqueness: {scope: :photo_id}
  validates :helpful_id, :photo_id, :user_id, numericality: true, allow_nil: true

  after_create { photo.update_details }
  after_destroy { photo.update_details }
  after_update { photo.update_details }

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

  def self.creation(detail_photo_id, detail_params)
    photo = Photo.find(detail_photo_id)

    photo.photo_details.new(detail_params)
  end

end
