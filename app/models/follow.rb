class Follow < ActiveRecord::Base
  attr_accessible :fan_id, :leader_id

  validates :fan_id, :leader_id, presence: true

  belongs_to(
    :fan,
    class_name: "User",
    primary_key: :id,
    foreign_key: :fan_id
  )

  belongs_to(
    :leader,
    class_name: "User",
    primary_key: :id,
    foreign_key: :leader_id
  )

end
