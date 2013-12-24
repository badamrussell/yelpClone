class Tip < ActiveRecord::Base
  attr_accessible :body, :user_id, :business_id

  validates :body, :user_id, :business_id, presence: true

  belongs_to(
    :user ,
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
