class Bookmark < ActiveRecord::Base
  attr_accessible :business_id, :user_id

  validates :business_id, :user_id, presence: true

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id
  )

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

end
