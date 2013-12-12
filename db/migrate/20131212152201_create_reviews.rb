class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.integer :user_id
      t.integer :business_id
      t.text :body

      t.timestamps
    end

    add_index :reviews, :user_id
    add_index :reviews, :business_id
  end
end
