class CreateReviewVotes < ActiveRecord::Migration
  def change
    create_table :review_votes do |t|
      t.integer :review_id, null: false
      t.integer :vote_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :review_votes, :review_id
    add_index :review_votes, :vote_id
    add_index :review_votes, :user_id
  end
end
