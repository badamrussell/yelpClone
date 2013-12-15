class CreateReviewCompliments < ActiveRecord::Migration
  def change
    create_table :review_compliments do |t|
        t.integer :review_id, null: false
        t.integer :compliment_id, null: false
        t.text :body
        t.integer :user_id, null: false

        t.timestamps
      end

      add_index :review_compliments, :review_id
      add_index :review_compliments, :compliment_id
      add_index :review_compliments, :user_id
  end
end
