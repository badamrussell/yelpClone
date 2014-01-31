class DropBusinessCategories < ActiveRecord::Migration
  def change
  	drop_table :business_categories
  end
end
