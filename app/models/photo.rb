class Photo < ActiveRecord::Base
  attr_accessible :business_id, :user_id, :review_id, :file, :caption
  attr_accessible :store_front_count, :helpful_sum

  validates :user_id, presence: true, numericality: true
  validates :business_id, :review_id, numericality: true, allow_nil: true

  after_create :update_business
  after_destroy :update_business
  after_update :update_business

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
    showcase: "300x300^"
  }

  def update_details
    totals = { store_front_count: 0, helpful_sum: 0 }

    photo_details.all.each do |detail|
      totals[:helpful_sum] += (detail.helpful_id ? Helpful.find(detail.helpful_id).value : 0)
      totals[:store_front_count] += 1 if detail.store_front
    end
    
    update_attributes(totals)
  end

  def update_business
    self.business.update_store_fronts if self.business_id
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
