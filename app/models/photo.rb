class Photo < ActiveRecord::Base
  attr_accessible :business_id, :user_id, :review_id, :file, :caption
  attr_accessible :store_front_count, :helpful_sum

  validates :user_id, presence: true
  after_create :update_details
  after_destroy :update_details
  after_update :update_details

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
    small: "30x30#",
    medium: "60x60#",
    large: "150x150#",
    showcase: "300x300#"
  }

  def update_details
    if self.business_id

      biz = self.business

      details = biz.store_front_count(2)

      if details.empty? && biz.store_front_id
        biz.update_attribute(:store_front_id, nil)
      elsif details[0].id != biz.store_front_id
        biz.update_attribute(:store_front_id, details[0].id)
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

  def user_details(user_id)
    photo_details.where(user_id: user_id)
  end
end
