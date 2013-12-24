class Country < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :businesses,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id
  )


end
