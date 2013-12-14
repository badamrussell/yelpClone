class Category < ActiveRecord::Base
  attr_accessible :main_category_id, :name

  validates :main_category_id, :name, presence: true




  def businesses
    sql = <<-SQL
      SELECT *
      FROM businesses
      WHERE category1_id = ? OR category2_id = ? OR category3_id = ?
    SQL

    Business.find_by_sql([sql,id, id, id])
  end

  def best_businesses(size)
    sql = <<-SQL
      SELECT *
      FROM businesses
      WHERE category1_id = ? OR category2_id = ? OR category3_id = ?
    SQL

    Business.find_by_sql([sql,id, id, id]).sort[0...size]
  end

  def new_businesses(size)
    sql = <<-SQL
      SELECT *
      FROM businesses
      WHERE category1_id = ? OR category2_id = ? OR category3_id = ?
      ORDER BY businesses.created_at DESC
      LIMIT ?
    SQL

    Business.find_by_sql([sql,id, id, id, size])
  end

  def new_photos(size)
    sql = <<-SQL
      SELECT *
      FROM photos
      INNER JOIN businesses ON businesses.id = photos.business_id
      WHERE businesses.category1_id = ? OR businesses.category2_id = ? OR businesses.category3_id = ?
      ORDER BY photos.created_at DESC
      LIMIT ?
    SQL

    Photo.find_by_sql([sql,id, id, id, size])
  end

  def new_reviews(size)
    sql = <<-SQL
      SELECT *
      FROM reviews
      INNER JOIN businesses ON businesses.id = reviews.business_id
      WHERE businesses.category1_id = ? OR businesses.category2_id = ? OR businesses.category3_id = ?
      ORDER BY reviews.created_at DESC
      LIMIT ?
    SQL

    Review.find_by_sql([sql,id, id, id, size])
  end
end
