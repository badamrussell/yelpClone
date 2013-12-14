class AppendFeatures < ActiveRecord::Migration
  def change
    add_column :features, :feature_category_id, :integer, default: 1
  end
end
