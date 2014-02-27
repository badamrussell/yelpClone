class UserBio < ActiveRecord::Base
  attr_accessible :headline, :love_name ,:find_me_in ,:hometown ,:website ,:reviews ,:secondsite ,:book ,:concert ,:movie ,:meal ,:dont_tell ,:recent_discovery ,:crush , :language_id, :not_yelp
  attr_accessible :user_id

  validates :user_id, presence: true
  validates :user_id, uniqueness: true
  validates :language_id, :user_id, numericality: true

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

  def creation(user, profile_params, user_params)
    trans_errors = []

    ActiveRecord::Base.transaction do
      self.update_attributes(profile_params)
      user.update_attributes(user_params)

      trans_errors += profile.errors.full_messages
      trans_errors += user.errors.full_messages
    end

    trans_errors
  end

end
