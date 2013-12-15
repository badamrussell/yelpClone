class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :business_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :bookmarks, :business_id
    add_index :bookmarks, :user_id
  end
end
