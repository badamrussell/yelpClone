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
    foreign_key: :photo_id
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
    showcase: "200x200#"
  }

  def update_details(increment)
    if self.business_id
      biz = self.business

      if biz.missing_store_front?
        biz.update_attribute(:store_front_id, self.id)
      elsif biz.store_front_id == self.id

      else
        details = photo_details.where(store_front: true).order(:store_front_count)

        if details.empty?
          biz.update_attribute(:store_front_id, self.id)
        elsif details[0].id == biz.store_front_id

        else
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
