class UserBio < ActiveRecord::Base
  attr_accessible :headline, :love_name ,:find_me_in ,:hometown ,:website ,:reviews ,:secondsite ,:book ,:concert ,:movie ,:meal ,:dont_tell ,:recent_discovery ,:crush , :language_id

  validates :user_id, presence: true
  validates :user_id, uniqueness: true

  has_one(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

end
