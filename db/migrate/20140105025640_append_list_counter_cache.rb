class AppendListCounterCache < ActiveRecord::Migration
  def change
    add_column :lists, :list_reviews_count, :integer, default: 0
  end
end
