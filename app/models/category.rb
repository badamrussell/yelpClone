class Category < ActiveRecord::Base
  attr_accessible :main_category_id, :name

  validates :main_category_id, :name, presence: true




  def businesses
    sql = <<-SQL
      SELECT *
      FROM businesses
      WHERE category1_id = ? OR category2_id = ? OR category3_id = ?
    SQL

    self.find_by_sql(sql, self.id, self.id, self.id)
  end


end
