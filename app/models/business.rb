class Business < ActiveRecord::Base
  attr_accessible :country_id ,:name ,:address1 ,:address2 ,:city ,:state ,:zip_code ,:phone_number ,:website, :neighborhood_id, :latitude, :longitude
  attr_accessible :rating_avg, :store_front_id, :reviews_count, :photos_count, :price_range_avg
  attr_accessible :hours0, :hours1, :hours2, :hours3, :hours4, :hours5, :hours6
  attr_accessible :category1_id, :category2_id, :category3_id

  validates :name, :country_id, presence: true
  validates :country_id, :neighborhood_id, numericality: true
  validates :store_front_id, numericality: true, allow_nil: true

  geocoded_by :full_street_address
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  before_validation :set_neighborhood
  after_touch { tire.update_index }

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
    inverse_of: :business,
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

  has_one(
    :category1,
    class_name: "Category",
    primary_key: :id,
    foreign_key: :category1_id
  )

  has_one(
    :category2,
    class_name: "Category",
    primary_key: :id,
    foreign_key: :category2_id
  )

  has_one(
    :category3,
    class_name: "Category",
    primary_key: :id,
    foreign_key: :category3_id
  )

  def business_hours
    @hours_open ||= 5.times.map { |index| BusinessSchedule.new(index, 8.hours, 18.hours) }
  end

  def category_ids=(ids)
    category1_id = ids[0] if ids[0]
    category2_id = ids[1] if ids[1]
    category3_id = ids[2] if ids[2]
  end

  def categories
    Category.where(id: [category1_id, category2_id, category3_id])
  end

  def store_fronts(size)
    photos.select("photos.id, COUNT(CASE WHEN photo_details.store_front THEN 1 ELSE null END) AS photo_count")
          .joins("LEFT JOIN photo_details ON photo_details.photo_id = photos.id")
          .group("photos.id")
          .order("photo_count DESC, photos.id DESC")
          .limit(size).all
  end

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
    return "/assets/default_house.jpg" unless store_front_id

    if photos.loaded?
      photos.select { |p| p.id == store_front_id }[0].url(size)
    elsif store_front_photo
      store_front_photo.url(size)
    else
      Photo.find(store_front_id).url(size)
    end
  end

  def get_highlight_reviews(amount)
    @highlight_reviews ||= self.reviews.order("rating DESC").first(4)
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

  def now_hours 
    day = business_hours[Time.now.wday] if Time.now.wday < business_hours.length

    day ? day.open_hours : ""
  end

  def is_open?
    day = business_hours[Time.now.wday] if Time.now.wday < business_hours.length

    time_now = Time.now.hour.hours + Time.now.min.minutes
    day && (day.time_open..day.time_close) === time_now
  end  

  def creation_transaction(review_params, photo_params)
    trans_errors = []

    self.transaction do

      if has_field?(review_params, :body)
        review = self.reviews.build(review_params)

        review.photos.build(photo_params) if has_field?(photo_params, :file)
      end

      save

      trans_errors = self.errors.full_messages
    end

    trans_errors
  end

  def location
    [{ type: "point", lat: latitude, lon: longitude }]
  end

  def as_json(options={})
    if options.empty?
      super(methods: [:avatar, :rating_string, :categories ], include: [:business_features, :top_review, neighborhood: { include: :area } ])
    else
      super options
    end
  end

  def to_elasticsearch_json
    to_json( include: { top_review: { only: [:body], methods: [:user_avatar] },
                        neighborhood: { include: :area },
                        business_features: { only: [:feature_id] },
                        # reviews: { only: [:id, :body] }
                      },
              methods: [:avatar, :rating_string, :location, :categories],
              only: [:name, :id, :address1 ,:address2, :neighborhood_id, :longitude, :latitude, :city, :zip_code, :price_range_avg, :reviews_count]
            )
  end

  def self.where_categories(ids)
    Business.where("category1_id IN (?) OR category2_id IN (?) OR category3_id IN (?)", ids, ids, ids)
  end

  private

  def has_field?(params, field_name)
    !params[field_name].blank?
  end

end
