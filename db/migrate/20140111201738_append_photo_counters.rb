class AppendPhotoCounters < ActiveRecord::Migration
  def change
    add_column :photos, :helpful_sum, :integer, default: 0
  end
end
