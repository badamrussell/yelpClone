class CreatePhotoDetails < ActiveRecord::Migration
  def change
    create_table :photo_details do |t|
      t.integer :photo_id, null: false
      t.integer :helpful_id
      t.boolean :store_front
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :photo_details, :photo_id
    add_index :photo_details, :user_id
  end
end
