class RemoveRatingBusiness < ActiveRecord::Migration
  def change
    remove_column :businesses, :rating
  end
end
