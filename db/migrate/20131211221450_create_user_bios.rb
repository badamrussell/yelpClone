class CreateUserBios < ActiveRecord::Migration
  def change
    create_table :user_bios do |t|
      t.string :headline
      t.string :love_name
      t.string :not_yelp
      t.string :find_me_in
      t.string :hometown
      t.string :website
      t.string :reviews
      t.string :secondsite
      t.string :book
      t.string :concert
      t.string :movie
      t.string :meal
      t.string :dont_tell
      t.string :recent_discovery
      t.string :crush
      t.integer :language_id, default: 1
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :user_bios, :user_id
  end
end
