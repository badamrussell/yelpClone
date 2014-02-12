class Business < ActiveRecord::Base
  include BusinessPhoto, BusinessCategory, BusinessLocation

  attr_accessible :country_id ,:name ,:address1 ,:address2 ,:city ,:state ,:zip_code ,:phone_number ,:website, :neighborhood_id, :latitude, :longitude
  attr_accessible :rating_avg, :store_front_id, :reviews_count, :photos_count, :price_range_avg
  attr_accessible :hours0, :hours1, :hours2, :hours3, :hours4, :hours5, :hours6
  attr_accessible :category1_id, :category2_id, :category3_id

  validates :name, :country_id, presence: true
  validates :country_id, :neighborhood_id, numericality: true
  validates :store_front_id, numericality: true, allow_nil: true


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

  
  def self.recent(num)
    Business.limit(num).includes(:neighborhood, :photos)
  end

  def get_highlight_reviews(amount=4)
    @highlight_reviews ||= self.reviews.order("rating DESC").first(amount)
  end

  def business_hours
    @hours_open ||= 5.times.map { |index| BusinessSchedule.new(index, 8.hours, 18.hours) }
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

  def <=>(otherBiz)
    return 1 if otherBiz.rating_avg < rating_avg
    return -1 if otherBiz.rating_avg > rating_avg
    0
  end

  def rating_string
    return "0" if self.rating_avg < 1
    l,r = rating_avg.round(1).to_s.split(".")

    r = r.to_i < 5 ? "0" : "5"

    l + r
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

  def as_json(options={})
    if options.empty?
      super(methods: [:avatar, :rating_string, :categories ], include: [:business_features, :top_review, neighborhood: { include: :area } ])
    else
      super options
    end
  end

  # def to_elasticsearch_json
  #   to_json( include: { top_review: { only: [:body], methods: [:user_avatar] },
  #                       neighborhood: { include: :area },
  #                       business_features: { only: [:feature_id] },
  #                       # reviews: { only: [:id, :body] }
  #                     },
  #             methods: [:avatar, :rating_string, :location, :categories],
  #             only: [:name, :id, :address1 ,:address2, :neighborhood_id, :longitude, :latitude, :city, :zip_code, :price_range_avg, :reviews_count]
  #           )
  # end

  

  private

  def has_field?(params, field_name)
    !params[field_name].blank?
  end

end
