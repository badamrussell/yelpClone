class Category < ActiveRecord::Base
  attr_accessible :main_category_id, :name

  validates :main_category_id, :name, presence: true

  belongs_to(
    :main_category,
    class_name: "MainCategory",
    primary_key: :id,
    foreign_key: :main_category_id
  )

  belongs_to(
    :business_category,
    class_name: "BusinessCategory",
    primary_key: :id,
    foreign_key: :category_id
  )

  def self.parent_category(category_id)
    MainCategory.find(Category.find(category_id).main_category_id)
  end

  def businesses
    sql = <<-SQL
      SELECT businesses.*
      FROM businesses
      JOIN business_categories ON businesses.id = business_categories.business_id
      WHERE business_categories.category_id = ?
    SQL

    Business.find_by_sql([sql,id])
  end

  def top_five_businesses
    Business.includes(:photos)
      .joins("JOIN business_categories ON businesses.id = business_categories.business_id")
      .where("business_categories.category_id = #{id}")
      .limit(5)
  end

  def new_businesses(size)
    sql = <<-SQL
      SELECT businesses.*
      FROM businesses
      JOIN business_categories ON businesses.id = business_categories.business_id
      WHERE business_categories.category_id = ?
      ORDER BY businesses.created_at DESC
      LIMIT ?
    SQL

    # Business.find_by_sql([sql, id, size])
    Business.includes(:store_front_photo, :neighborhood)
      .joins("JOIN business_categories ON businesses.id = business_categories.business_id")
      .where("business_categories.category_id = #{id}")
      .order("businesses.created_at DESC")
      .limit(size)

  end

  def new_photos(size)
    sql = <<-SQL
      SELECT photos.*
      FROM photos
      INNER JOIN businesses ON businesses.id = photos.business_id
      JOIN business_categories ON businesses.id = business_categories.business_id
      WHERE business_categories.category_id = ?
      ORDER BY businesses.created_at DESC
      LIMIT ?
    SQL

    Photo.find_by_sql([sql, id, size])



  end

  def new_reviews(size)
    Review.includes(:user, :business)
      .joins("INNER JOIN businesses ON businesses.id = reviews.business_id JOIN business_categories ON businesses.id = business_categories.business_id")
      .where("business_categories.category_id = #{id}")
      .order("businesses.created_at DESC")
      .limit(size)
  end
end
