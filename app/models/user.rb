class User < ActiveRecord::Base
  attr_accessible :birthdate, :email, :first_name, :last_name, :nickname, :session_token, :password, :profile_photo
  attr_accessible :year, :month, :day
  attr_reader :password

  validates :email, :session_token, :first_name, :last_name, presence: true
  validates :password_digest, presence: { message: "Password cannot be blank." }
  validates :password, length: { minimum: 6 }, on: :create
  validates :email, uniqueness: true
  before_validation :ensure_token

  has_one(
    :bio,
    class_name: "UserBio",
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many(
    :reviews,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many(
    :profile_locations,
    class_name: "ProfileLocation",
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many(
    :photos,
    class_name: "Photo",
    primary_key: :id,
    foreign_key: :user_id
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
    foreign_key: :user_id
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
    :lists,
    class_name: "List",
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many(
    :follows,
    class_name: "User",
    primary_key: :id,
    foreign_key: :leader_id
  )

  has_many :fans, through: :follows, source: :fan

  has_many(
    :followees,
    class_name: "User",
    primary_key: :id,
    foreign_key: :fan_id
  )

  has_many :leaders, through: :followees, source: :leader

  has_many(
    :bookmarks,
    class_name: "Bookmark",
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many :bookmarked_businesses, through: :bookmarks, source: :business


  has_attached_file :profile_photo, styles: {
    thumbnail: "40x40#",
    icon: "90x90#"
  }


  #--temporary placeholders until associations can be made
  def friends
    []
  end

  def fans
    [1,2,3,4]
  end

  def self.random_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.verify_credentials(email, secret)
    user = User.find_by_email(email)

    if user && user.pw_matches?(secret)
      user
    else
      nil
    end
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

  def avatar
    profile_photo_file_name ? self.profile_photo.url : "/assets/temp/default_user.jpg"
  end

  def display_location
    #needs to be better and choose primary
    self.profile_locations.first.address
  end

  def photo_details_for(photo)
    self.photo_details.where(photo_id: photo.id)[0]
  end

  def top_photos(qty)
    photos.limit(qty)
  end

  def voted?(review, vote_id)
    review_votes.where(review_id: review.id, vote_id: vote_id).any?
  end

  def get_vote(review, vote_id)
    results = review_votes.where(review_id: review.id, vote_id: vote_id)

    results[0] ? results[0].id : nil
  end

  def compliment_count
    sql = <<-SQL
      SELECT compliments.id AS id, compliments.name AS name, COUNT(compliments.id) AS count
      FROM compliments
      INNER JOIN review_compliments ON review_compliments.compliment_id = compliments.id
      INNER JOIN reviews ON reviews.id = review_compliments.review_id
      WHERE reviews.user_id = ?
      GROUP BY compliments.id
    SQL

    result = Compliment.find_by_sql([sql, id])
    result.map { |r| r.attributes }
  end

  def achievements
    list = []

  end

  private

  def ensure_token
    self.session_token ||= self.class.random_token
  end

end
