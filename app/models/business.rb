class Business < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :country_id ,:name ,:address1 ,:address2 ,:city ,:state ,:zip_code ,:phone_number ,:website,:category1_id ,:category2_id ,:category3_id, :store_front_id, :neighborhood_id

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
    foreign_key: :business_id,
    order: "created_at DESC"
  )

  has_many(
    :business_features,
    class_name: "BusinessFeature",
    primary_key: :id,
    foreign_key: :business_id
  )

  has_many :features, through: :business_features, source: :feature

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

  has_many :photo_details, through: :photos, source: :photo_details


  def <=>(otherBiz)
    return 1 if otherBiz.rating < rating
    return -1 if otherBiz.rating > rating
    0
  end

  def self.best(categoryID)
    Business.all[0..4]
  end

  def self.best_random(category_id, size)
    best = []

    Business.all.limit(size)

    best
  end

  def first_review

  end

  def categories(category_id)
    sql = <<-SQL
      SELECT *
      FROM businesses
      WHERE category1_id = ? OR category2_id = ? OR category3_id = ?
    SQL

    Business.find_by_sql([sql,category_id,category_id,category_id])
  end

  def self.find_from_categories(cat1)
    sql = <<-SQL
      SELECT *
      FROM businesses
      WHERE category1_id = ? OR category2_id = ? OR category3_id = ?
    SQL

    Business.find_by_sql([sql,cat1,cat1,cat1])
  end

  def store_front_photo
    # store_front_id ? self.store_front : "/assets/temp/photo_med_square.jpg"
    fronts = store_front_search.map { |pd| pd.photo.img_url }

    fronts << "/assets/temp/photo_med_square.jpg" if fronts.empty?

    fronts[0]
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
   fronts = store_front_search.map { |pd| pd.photo }

    photos.each do |p|
      break if fronts.length > 2
      next if fronts.include?(p)
      fronts << p
    end

    fronts
  end

  def missing_store_front?
    self.store_front_id.nil?
  end

  def rating
    return 0 if reviews.empty?
    reviews.inject(0) { |sum, r| sum + r.rating}/reviews.length
  end



  private

  def store_front_search
    photo_details.where(store_front: true)
  end
end
