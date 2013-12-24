class AppendPhotoReviews < ActiveRecord::Migration
  def change
    add_column :photos, :review_id, :integer
  end
end
