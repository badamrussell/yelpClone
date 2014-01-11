class Business < ActiveRecord::Base
  attr_accessible :country_id ,:name ,:address1 ,:address2 ,:city ,:state ,:zip_code ,:phone_number ,:website, :neighborhood_id, :category_ids, :latitude, :longitude
  attr_accessible :rating_avg, :store_front_id, :reviews_count, :photos_count, :price_range_avg

  validates :name, :country_id, presence: true

  geocoded_by :full_street_address
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  before_validation :set_neighborhood

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
    dependent: :destroy
  )

  has_one(
    :top_review,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :business_id,
    order: "rating DESC",
    include: :user
  )

  has_many(
    :business_categories,
    class_name: "BusinessCategory",
    primary_key: :id,
    foreign_key: :business_id,
    dependent: :destroy
  )

  has_many :categories, through: :business_categories, source: :category

  has_many(
    :business_features,
    class_name: "BusinessFeature",
    primary_key: :id,
    foreign_key: :business_id
  )

  has_many :features, through: :business_features, source: :feature

  belongs_to(
    :store_front_photo,
    class_name: "Photo",
    primary_key: :id,
    foreign_key: :store_front_id
  )

  belongs_to(
    :neighborhood,
    class_name: "Neighborhood",
    primary_key: :id,
    foreign_key: :neighborhood_id
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

  has_many(
    :tips,
    class_name: "Tip",
    primary_key: :id,
    foreign_key: :business_id,
    dependent: :destroy
  )

  has_many(
    :bookmarks,
    class_name: "Bookmark",
    primary_key: :id,
    foreign_key: :business_id,
    dependent: :destroy
  )

  has_many :bookmarkers, through: :bookmarks, source: :user

  has_many(
    :business_hours,
    class_name: "BusinessHour",
    primary_key: :id,
    foreign_key: :business_id,
    dependent: :destroy
  )

  def full_street_address
    a1 = address1 || ""
    a2 = address2 || ""
    c1 = city || ""
    s1 = state || ""
    z1 = zip_code || ""

    "#{a1} #{a2} #{c1}, #{s1} #{z1}"
  end

  def set_neighborhood
    self.neighborhood_id = Neighborhood.random_neighborhood(1) unless self.neighborhood_id
  end

  def address=(arg)
    addr = arg.split(",").map { |a| a.strip }
    self.address1 = addr[0]
    self.city = addr[1]
    self.state = addr[2].split(" ")[0]
    self.zip_code = addr[2].split(" ")[1].to_i
  end

  def <=>(otherBiz)
    return 1 if otherBiz.rating < rating
    return -1 if otherBiz.rating > rating
    0
  end

  def self.recent(num)
    Business.limit(num).includes(:neighborhood, :photos)
  end

  def gps
    { lat: latitude, lng: longitude }
  end

  def avatar(size = nil)
    return "/assets/temp/default_house.jpg" unless store_front_id

    if photos.loaded?
      photos.select { |p| p.id == store_front_id }[0].url(size)
    elsif store_front_photo
      store_front_photo.url(size)
    else
      Photo.find(store_front_id).url(size)
    end
  end

  def get_highlight_reviews(amount)
    self.reviews[0..3]
  end

  def missing_store_front?
    self.store_front_id.nil?
  end

  def rating
    self.rating_avg
  end

  def rating_string
    return "0" if self.rating < 1
    l,r = rating_avg.round(1).to_s.split(".")

    r = r.to_i < 5 ? "0" : "5"

    l + r
  end

  def price_range
    price_range_avg
  end

  def now_hours
    # Sunday is 0
    d = if business_hours.loaded?
        business_hours.select { |d| d.day_id = Time.now.wday}[0]
      else
        business_hours.where(day_id: Time.now.wday)[0]
      end

    d ? d.open_hours : ""
  end

  def is_open?
    d = business_hours.where(day_id: Time.now.wday)[0]

    time_now = Time.now.hour.hours + Time.now.min.minutes
    return true if d && (d.time_open..d.time_close) === time_now

    false
  end

  def as_json(options={})
    super(methods: [:avatar, :rating_string, :top_review], include: [:categories, :neighborhood])
  end

end
