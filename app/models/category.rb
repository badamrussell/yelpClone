class Category < ActiveRecord::Base
  attr_accessible :main_category_id, :name

  validates :main_category_id, :name, presence: true
  validates :main_category_id, numericality: true

  belongs_to(
    :main_category,
    class_name: "MainCategory",
    primary_key: :id,
    foreign_key: :main_category_id
  )

  def self.best_businesses(num, id_set)
    Business.where("businesses.category1_id IN (?) OR businesses.category2_id IN (?) OR businesses.category3_id IN (?)", id_set, id_set, id_set)
            .order("rating_avg DESC")
            .limit(num)
            .uniq
  end

  def top_five_businesses
    Business.includes(:photos)
            .where("businesses.category1_id = ? OR businesses.category2_id = ? OR businesses.category3_id = ?", id, id, id)
            .limit(5)
  end

  def new_businesses(size)
    Business.includes(:store_front_photo, :neighborhood)
      .where("businesses.category1_id IN (?) OR businesses.category2_id IN (?) OR businesses.category3_id IN (?)", id, id, id)
      .order("businesses.created_at DESC")
      .limit(size)
  end

  def new_photos(size)
    Photo.joins(:business)
        .where("businesses.category1_id IN (?) OR businesses.category2_id IN (?) OR businesses.category3_id IN (?)", id, id, id)
        .order("businesses.created_at DESC")
        .limit(size)
  end

  def new_reviews(size)
    Review.includes(:user, :business)
      .joins(:business)
      .where("businesses.category1_id IN (?) OR businesses.category2_id IN (?) OR businesses.category3_id IN (?)", id, id, id)
      .order("businesses.created_at DESC")
      .limit(size)
  end



  protected

  def self.q_set(size)
    size.times.map { "?" }.join(",")
  end


end
