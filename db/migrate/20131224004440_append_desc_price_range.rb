class AppendDescPriceRange < ActiveRecord::Migration
  def change
  	add_column :price_ranges , :description, :string
  end
end
