class CreateAmbienceReviews < ActiveRecord::Migration
  def change
    create_table :ambience_reviews do |t|
      t.integer :ambience_id
      t.integer :restaurant_detail_id

      t.timestamps
    end

    add_index :ambience_reviews, :ambience_id
    add_index :ambience_reviews, :restaurant_detail_id
  end
end
