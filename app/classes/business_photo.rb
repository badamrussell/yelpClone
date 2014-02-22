module BusinessPhoto
  extend ActiveSupport::Concern

  included do
    belongs_to(
      :store_front_photo,
      class_name: "Photo",
      primary_key: :id,
      foreign_key: :store_front_id
    )

    has_many(
      :photos,
      class_name: "Photo",
      primary_key: :id,
      foreign_key: :business_id
    )

    has_many(
      :main_photos,
      class_name: "Photo",
      primary_key: :id,
      foreign_key: :business_id,
      order: "helpful_sum DESC"
    )

    has_many :photo_details, through: :photos, source: :photo_details
  end

  def store_fronts(size)
    photos.select("photos.id, COUNT(CASE WHEN photo_details.store_front THEN 1 ELSE null END) AS photo_count")
          .joins("LEFT JOIN photo_details ON photo_details.photo_id = photos.id")
          .group("photos.id")
          .order("photo_count DESC, photos.id DESC")
          .limit(size).all
  end

  def avatar(size = nil)
    # puts "AVATAR: #{id}: #{store_front_id}"
    return "/assets/default_house.jpg" unless store_front_id

    if photos.loaded?
      photos.select { |p| p.id == store_front_id }[0].url(size)
    elsif store_front_photo
      store_front_photo.url(size)
    else
      Photo.find(store_front_id).url(size)
    end
  end

  def missing_store_front?
    self.store_front_id.nil?
  end

end