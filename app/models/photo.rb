class Photo < ActiveRecord::Base
  attr_accessible :business_id, :user_id, :review_id, :file, :caption
  attr_accessible :store_front_count

  validates :user_id, presence: true
  after_create { update_details(1) }
  after_destroy { update_details(-1) }
  after_update { update_details(0) }

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id,
    counter_cache: true
  )

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id,
    counter_cache: true
  )

  has_many(
    :photo_details,
    class_name: "PhotoDetail",
    primary_key: :id,
    foreign_key: :photo_id,
    dependent: :destroy
  )

  belongs_to(
    :review,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :review_id
  )

  has_attached_file :file, styles: {
    icon_s: "30x30#",
    small: "150x150>",
    showcase: "300x300#"
  }

  def update_details(increment)
    if self.business_id
      biz = self.business

      details = biz.photos
                .select("photos.id, COUNT(photo_details.store_front) AS photo_count")
                .joins("LEFT JOIN photo_details ON photo_details.photo_id = photos.id")
                .group("photos.id")
                .order("photo_count DESC, photos.id DESC")
                .limit(2).all

      if increment == -1
        if biz.store_front_id == self.id
          biz.store_front_id = nil

          details.each do |d|
            next if d.id == self.id
            biz.store_front_id = d.id
            break
          end

          biz.save
        end
      elsif biz.missing_store_front?
        biz.update_attribute(:store_front_id, self.id)
      else
        if details.empty?
          biz.update_attribute(:store_front_id, self.id)
        elsif details[0].id != biz.store_front_id
          biz.update_attribute(:store_front_id, details[0].id)
        end
      end
    end
  end

  def is_store_front?
    business.store_front_id == self.id
  end

  def url(size = nil)
    file.url(size)
  end

  def avatar
    business_id ? business.avatar : user.avatar
  end

  def title
    caption.blank? ? business.name : caption
  end

  def title_snippet
    title.length > 48 ? "#{title}..."[0..50] : title
  end
end
