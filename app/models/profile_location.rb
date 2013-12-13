class ProfileLocation < ActiveRecord::Base
  attr_accessible :user_id, :name, :address, :primary

  validates :user_id, :name, :address, presence: true


  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

end
