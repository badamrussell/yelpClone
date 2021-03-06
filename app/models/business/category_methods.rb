class Business
module CategoryMethods
  extend ActiveSupport::Concern

  included do
    belongs_to(
      :category1,
      class_name: "Category",
      primary_key: :id,
      foreign_key: :category1_id
    )

    belongs_to(
      :category2,
      class_name: "Category",
      primary_key: :id,
      foreign_key: :category2_id
    )

    belongs_to(
      :category3,
      class_name: "Category",
      primary_key: :id,
      foreign_key: :category3_id
    )
  end


  def category_ids=(ids)
    self.category1_id = ids[0] if ids[0]
    self.category2_id = ids[1] if ids[1]
    self.category3_id = ids[2] if ids[2]
  end

  def categories
    Category.where(id: [category1_id, category2_id, category3_id])
  end

  def self.where_categories(ids)
    Business.where("category1_id IN (?) OR category2_id IN (?) OR category3_id IN (?)", ids, ids, ids)
  end

end
end