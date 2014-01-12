class ChangeBusinessFeatureReviewId < ActiveRecord::Migration
  def change
    change_column :business_features, :review_id, :integer, null: false
  end
end
