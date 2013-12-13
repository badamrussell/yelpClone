class Photo < ActiveRecord::Base
  attr_accessible :business_id, :img_url, :store_front, :user_id

  validates :img_url, :user_id, presence: true

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id
  )

end
