class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id, null: false
      t.integer :business_id
      t.string :caption
      t.integer :store_front_count, default: 0
      t.attachment :file

      t.timestamps
    end

    add_index :photos, :user_id
    add_index :photos, :business_id
  end
end
