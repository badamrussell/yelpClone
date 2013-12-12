class Category < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many(
    :sub_categories,
    class_name: "SubCategory",
    primary_key: :id,
    foreign_key: :category_id
  )

end
