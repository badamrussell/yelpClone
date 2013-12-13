class Business < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :country_id ,:name ,:address1 ,:address2 ,:city ,:state ,:zip_code ,:phone_number ,:website,:category1_id ,:category2_id ,:category3_id, :store_front_id

  validates :name, :country_id, presence: true

  belongs_to(
    :country,
    class_name: "Country",
    primary_key: :id,
    foreign_key: :country_id
  )

  has_many(
    :reviews,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :business_id
  )

  has_one(
    :store_front,
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


  def self.best(categoryID)
    Business.all[0..5]
  end

  def store_front_photo
    store_front_id ? self.store_front : "/assets/temp/photo_med_square.jpg"
  end

  def category_list
    ["food", "stuff"]
  end

  def neighborhood
    "WRONG PLACE"
  end

  def top_review
    Review.first
  end

  def get_highlight_reviews(amount)
    self.reviews[0..3]
  end

  def main_photos
    p = []
    p << store_front if store_front_id

    self.photos.each do |photo|
      break if p.length > 2
      p << photo unless p.include?(photo)
    end

    p
  end

  def missing_store_front?
    self.store_front_id.nil?
  end

  def rating
    reviews.inject(0) { |sum, r| sum + r.rating}/reviews.length
  end

end
