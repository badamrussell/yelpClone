class Business < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :country_id ,:name ,:address1 ,:address2 ,:city ,:state ,:zip_code ,:phone_number ,:website, :neighborhood_id, :category_ids, :gps

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

  has_many(
    :business_categories,
    class_name: "BusinessCategory",
    primary_key: :id,
    foreign_key: :business_id
  )

  has_many :categories, through: :business_categories, source: :category

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

  has_many(
    :tips,
    class_name: "Tip",
    primary_key: :id,
    foreign_key: :business_id
  )

  has_many(
    :bookmarks,
    class_name: "Bookmark",
    primary_key: :id,
    foreign_key: :business_id
  )

  has_many :bookmarkers, through: :bookmarks, source: :user

  def <=>(otherBiz)
    return 1 if otherBiz.rating < rating
    return -1 if otherBiz.rating > rating
    0
  end

  def self.best(categoryID)
    Business.all[0..4]
  end

  def self.best_random(category_objs, size)
    cats = []
    category_objs.each do |c|
      cats << c.id
    end

    sql = <<-SQL
      SELECT *
      FROM businesses
      JOIN business_categories ON businesses.id = business_categories.business_id
      WHERE business_categories.category_id IN (?)
    SQL

    Business.find_by_sql([sql,cats])
  end

  def self.search(search_params)
    wheres = []
    values = []
    joins = []
    where = ""

    if search_params.keys.include?("feature_id")
      joins << "INNER JOIN business_features ON businesses.id = business_features.business_id"
    end
    if search_params.keys.include?("category_id")
      joins << "INNER JOIN business_categories ON businesses.id = business_categories.business_id"
    elsif search_params.keys.include?("main_category_id")
      joins << "INNER JOIN business_categories ON business_categories.business_id = businesses.id"
      joins << "INNER JOIN categories ON categories.id = business_categories.business_id"
      joins << "INNER JOIN main_categories ON main_categories.id = categories.main_category_id"
    end

    search_params.each do |key, value|
      wheres << " #{key} = ? "
      values << value
    end


    where = "WHERE #{wheres.join(" AND ")}" if wheres.any?

    sql = <<-SQL
      SELECT DISTINCT businesses.*
      FROM businesses
      #{joins.join("\n")}
      #{where}
    SQL



    values.unshift(sql)
    Business.find_by_sql(values)
  end

  def first_review

  end

  def avatar
    # store_front_id ? self.store_front : "/assets/temp/photo_med_square.jpg"
    fronts = store_front_search.map { |pd| pd.photo.url }

    fronts << "/assets/temp/default_house.jpg" if fronts.empty?

    fronts[0]
  end

  def category_list
    ["food", "stuff"]
  end

  def neighborhood
    "WRONG PLACE"
  end

  def top_review
    reviews.order("rating DESC").first
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

  def price_range
    business_features

    3
  end

  def avatar_tag(size_name="icon", link = "")
    size = 30 if size_name == "icon"

    "<a href='#{link}'><img width='#{size}' src='#{avatar}'></a>"
  end

  private

  def store_front_search
    photo_details.where(store_front: true)
  end
end
