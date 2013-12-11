class User < ActiveRecord::Base
  attr_accessible :birthdate, :email, :first_name, :last_name, :nickname, :session_token, :password
  attr_reader :password

  validates :email, :session_token, :first_name, :last_name, presence: true
  validates :password_digest, presence: { message: "Password cannot be blank." }
  validates :password, length: { minimum: 6 }, on: :create
  before_validation :ensure_token


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

  private

  def ensure_token
    self.session_token ||= self.class.random_token
  end

end
