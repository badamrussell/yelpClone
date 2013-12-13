class AppendPhotoColumn < ActiveRecord::Migration
  def change
    add_column :businesses, :store_front_id, :integer
  end
end
