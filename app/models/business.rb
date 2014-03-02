class Business < ActiveRecord::Base
  include Business::PhotoMethods
  include Business::CategoryMethods
  include Business::LocationMethods

  attr_accessible :country_id ,:name ,:address1 ,:address2 ,:city ,:state ,:zip_code ,:phone_number ,:website, :neighborhood_id, :latitude, :longitude
  attr_accessible :rating_avg, :store_front_id, :reviews_count, :photos_count, :price_range_avg
  attr_accessible :hours0, :hours1, :hours2, :hours3, :hours4, :hours5, :hours6
  attr_accessible :category_ids

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
    Business.limit(num).includes(:neighborhood, :photos).order("created_at DESC")
  end

  def get_highlight_reviews(amount=4)
    @highlight_reviews ||= self.reviews.order("rating DESC").first(amount)
  end

  def business_hours
    # @hours_open ||= 5.times.map { |index| BusinessSchedule.new(index, 8.hours, 18.hours) }
    @business_schedule ||= BusinessSchedule.new
  end

  def add_hour(day_id, start_hour, close_hour)
    @business_schedule ||=  BusinessSchedule.new
    @business_schedule.add(day_id, start_hour, close_hour)
  end

  def now_hours
    @business_schedule ||=  BusinessSchedule.new
    @business_schedule.open_hours(Time.now.wday)
  end

  def is_open?
    @business_schedule ||=  BusinessSchedule.new
    @business_schedule.is_open?(Time.now.wday)
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

  private

  def has_field?(params, field_name)
    !params[field_name].blank?
  end

end
