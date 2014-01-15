class Bookmark < ActiveRecord::Base
  attr_accessible :business_id, :user_id

  validates :business_id, :user_id, presence: true, numericality: true

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id,
    include: [:photos, :top_review, :categories, :neighborhood]
  )

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id,
    include: [:photos, :profile_locations]
  )

end
