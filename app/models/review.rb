class Review < ActiveRecord::Base
  attr_accessible :rating, :user_id, :business_id, :body, :price_range, :feature_ids

  validates :rating, :user_id, :business, presence: true
  validates :body, presence: { message: "Review cannot be blank!" }
  validates :rating, numericality: { greater_than: 0 }
  validates :user_id, numericality: true

  before_destroy :destroy_features
  after_create { update_data(1) }
  after_destroy { update_data(-1) }
  after_update { update_data(0) }

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id,
    counter_cache: true,
    include: :profile_locations
  )

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id,
    counter_cache: true,
    inverse_of: :reviews,
    touch: true,
    include: [:neighborhood, :photos]
  )

  has_many :categories, through: :business, source: :categories

  has_many(
    :photos,
    class_name: "Photo",
    primary_key: :id,
    foreign_key: :review_id,
    dependent: :destroy
  )

  has_many(
    :business_features,
    class_name: "BusinessFeature",
    primary_key: :id,
    foreign_key: :review_id,
    inverse_of: :review,
    dependent: :destroy
  )

  has_many(
    :review_votes,
    class_name: "ReviewVote",
    primary_key: :id,
    foreign_key: :review_id,
    dependent: :destroy
  )

  has_many :votes, through: :review_votes, source: :vote

  has_many(
    :review_compliments,
    class_name: "ReviewCompliment",
    primary_key: :id,
    foreign_key: :review_id,
    include: [:user, :compliment],
    dependent: :destroy
  )

  has_many(
    :compliments,
    through: :review_compliments,
    source: :compliment
  )

  has_many(
    :list_reviews,
    class_name: "ListReview",
    primary_key: :id,
    foreign_key: :review_id,
    dependent: :destroy
  )

  has_many :lists, through: :list_review, source: :list

  def update_data(increment)
    rating_total =  0
    rating_count = business.reviews_count + increment
    price_range_total = 0
    price_range_count = increment

    business.reviews.each do |rev|
      rating_total += rev.rating
      if rev.price_range > 0
        price_range_total += rev.price_range
        price_range_count += 1
      end
    end

    rating_avg = rating_count > 0 ? rating_total / (rating_count.to_f) : 0

    price_range_avg = if price_range_count > 0
      new_price = (price_range_total / price_range_count).round
      new_price == 0 ? 1 : new_price
    else
      0
    end

    # if increment == 1
    #   biz_search = BusinessSearch.where(business_id: business_id).first
    #   biz_search ||= BusinessSearch.new(business_id: business_id, words: "")
    #
    #   current_words = body.downcase.gsub(/[^\s\w]/,"").split(" ")
    #   current_words = current_words.select { |w| w.length > 2 }
    #
    #   biz_search.words = (biz_search.words.split(" ") + current_words).uniq.join(" ")
    #   biz_search.save!
    # end

    business.update_attributes(price_range_avg: price_range_avg, rating_avg: rating_avg)
  end

  def snippet(size = 60)
    if self.body.include?(".")
      self.body[0, self.body.index(".")]
    elsif self.body.length < size
      self.body[0..size]
    else
      self.body[0..size] + "..."
    end
  end

  def destroy_features
    business_features.each { |bf| bf.destroy }
  end

  def completed_biz_features
    Hash[ business_features.map { |f| [f.feature_id, f.value] } ]
  end

  def self.recent(num)
    Review.limit(num).includes(:user, :business, :photos).order("reviews.updated_at DESC")
  end

  def rating_string
    "#{self.rating}0"
  end

  def user_avatar
    self.user.avatar
  end

  def business_avatar
    self.user.avatar
  end

  def as_json(options={})
    super(methods: [:user_avatar, :business_avatar], include: [:user])
  end

  def creation(new_values, new_features, new_photos, current_user)
    trans_errors = []
    existing_features = business_features.pluck(:feature_id)

    transaction do
      update_attributes!(new_values) if new_values

      business_features.each { |f| f.destroy unless new_features.keys.include?(f.feature_id) }


      new_features.each do |key,value|
        #if id.nil? does not seem to work...
        single_feature = if existing_features.include?(key)
              single_feature = self.business_features.where(feature_id: key, business_id: business_id)[0]
              single_feature.update_attributes(value: value)
              single_feature
            else
              self.business_features.build(feature_id: key, business_id: business_id, value: value)
            end

        trans_errors += single_feature.errors.full_messages
      end

      #save photo
      if new_photos && !new_photos[:file].blank?
        new_photos[:business_id] = business_id
        new_photos[:review_id] = id

        newPhoto = current_user.photos.build(new_photos)

        newPhoto.save
        trans_errors += newPhoto.errors.full_messages
      end

      save

      trans_errors += self.errors.full_messages
    end

    trans_errors
  end

end
