class User < ActiveRecord::Base

  attr_accessible :birthdate, :email, :first_name, :last_name, :nickname, :session_token, :password, :profile_photo
  attr_accessible :year, :month, :day
  attr_accessible :photos_count, :reviews_count, :review_compliments_count

  attr_protected :password_digest

  attr_reader :password

  validates :email, :session_token, :first_name, :last_name, presence: true
  validates :password_digest, presence: { message: "Password cannot be blank." }
  validates :password, length: { minimum: 6 }, on: :create
  validates :email, uniqueness: true

  before_validation :ensure_token
  after_create :initial_bio

  has_one(
    :bio,
    class_name: "UserBio",
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy
  )

  has_many(
    :reviews,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :user_id,
    include: [:photos, :business],
    dependent: :destroy
  )

  has_many(
    :profile_locations,
    class_name: "ProfileLocation",
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy
  )

  has_many(
    :photos,
    class_name: "Photo",
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy,
    order: :helpful_sum
  )

  has_many(
    :photo_details,
    class_name: "PhotoDetail",
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many(
    :tips ,
    class_name: "Tip",
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy
  )

  has_many(
    :review_votes,
    class_name: "ReviewVote",
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many :votes, through: :review_votes, source: :vote

  has_many :compliments, through: :reviews, source: :compliments

  has_many(
    :review_compliments,
    through: :reviews,
    source: :review_compliments,
    include: [:review, :user, :compliment]
  )

  has_many(
    :lists,
    class_name: "List",
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy
  )

  has_many(
    :follows,
    class_name: "Follow",
    primary_key: :id,
    foreign_key: :leader_id
  )

  has_many :fans, through: :follows, source: :fan

  has_many(
    :followees,
    class_name: "Follow",
    primary_key: :id,
    foreign_key: :fan_id
  )

  has_many :leaders, through: :followees, source: :leader

  has_many(
    :bookmarks,
    class_name: "Bookmark",
    primary_key: :id,
    foreign_key: :user_id,
    include: :business,
    dependent: :destroy
  )

  has_many :bookmarked_businesses, through: :bookmarks, source: :business


  has_attached_file :profile_photo, styles: {
    small: "30x30#",
    medium: "60x60#",
    large: "150x150#"
  }

  

  def self.random_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.verify_credentials(email, secret)
    user = User.find_by_email(email)

    (user && user.pw_matches?(secret)) ? user : nil
  end

  def password=(secret)
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)
  end

  def pw_matches?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end

  def reset_token
    self.session_token = self.class.random_token
    self.save!
  end

  def name
    "#{self.first_name} #{self.last_name[0]}."
  end

  def avatar(size = nil)
    profile_photo_file_name ? self.profile_photo.url(size) : "/assets/default_user.jpg"
  end

  def top_photos(qty)
    if photos.loaded?
      photos[0...qty]
    else
      photos.limit(qty)
    end
  end

  def voted?(review, vote_id)
    review_votes.where(review_id: review.id, vote_id: vote_id).any?
  end

  def get_vote(review, vote_id)
    results = review_votes.where(review_id: review.id, vote_id: vote_id)

    results[0] ? results[0].id : nil
  end

  def compliment_count
    result = Compliment.select("compliments.id AS id, compliments.name AS name, COUNT(compliments.id) AS count")
    .joins(:review_compliments, "JOIN reviews ON reviews.id = review_compliments.review_id")
    .where("reviews.user_id = ?", id)
    .group("compliments.id")

    result.map { |r| r.attributes }
  end

  def as_json(options={})
    super( methods: [:avatar, :name] )
  end


  #--temporary placeholders until features added
  def achievements
    list = []
  end

  def friends
    []
  end

  def friends_count
    0
  end

  def fans
    [1,2,3,4]
  end

  def fans_count
    4
  end

  def lists_count
    4
  end

  def vote_tallies
    return @tallies if @tallies

    @tallies = { "compliments" => compliments.count }
    Vote.all.each { |v| @tallies[v.name] = 0 }

    result = ReviewVote.select("votes.name, COUNT(votes.id) AS v_count")
                      .joins("JOIN votes on votes.id = review_votes.vote_id")
                      .where(review_id: reviews.pluck(:id))
                      .group("votes.id")

    result.all.each do |a|
      @tallies[a.attributes["name"].downcase] = a.attributes["v_count"].to_i
    end

    @tallies
  end

  private

  def ensure_token
    self.session_token ||= self.class.random_token
  end

  def initial_bio
    newBio = UserBio.new()
    newBio.user_id = self.id
    newBio.save!

    neighborhood = Area.determine_neighborhood()
    newLocation = self.profile_locations.create(address: neighborhood, name: "Home", primary: true)
  end
end
