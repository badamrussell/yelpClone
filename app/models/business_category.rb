class BusinessCategory < ActiveRecord::Base
  attr_accessible :business_id, :category_id

  validates :business, :category_id, presence: true
  validates :business_id, uniqueness: { scope: :category_id }

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id
  )

  belongs_to(
    :category,
    class_name: "Category",
    primary_key: :id,
    foreign_key: :category_id
  )

end
