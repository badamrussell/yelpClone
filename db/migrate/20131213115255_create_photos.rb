class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :img_url, null: false
      t.integer :user_id, null: false
      t.integer :business_id

      t.timestamps
    end

    add_index :photos, :user_id
    add_index :photos, :business_id
  end
end
