class SubCategory < ActiveRecord::Base
  attr_accessible :category_id, :name

  validates :category_id, :name, presence: true

  belongs_to(
    :category,
    class_name: "Category",
    primary_key: :id,
    foreign_key: :category_id
  )

end
