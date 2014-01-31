class AppendBusinessCategoriesHours < ActiveRecord::Migration
  def change
  	add_column :businesses, :category1_id, :integer
  	add_column :businesses, :category2_id, :integer
  	add_column :businesses, :category3_id, :integer


  	add_column :businesses, :hours0, :integer
  	add_column :businesses, :hours1, :integer
  	add_column :businesses, :hours2, :integer
  	add_column :businesses, :hours3, :integer
  	add_column :businesses, :hours4, :integer
  	add_column :businesses, :hours5, :integer
  	add_column :businesses, :hours6, :integer
  end
end
