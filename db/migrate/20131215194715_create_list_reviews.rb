class CreateListReviews < ActiveRecord::Migration
  def change
    create_table :list_reviews do |t|
      t.integer :list_id, null: false
      t.integer :review_id, null: false

      t.timestamps
    end

    add_index :list_reviews, :list_id
    add_index :list_reviews, :review_id
  end
end
