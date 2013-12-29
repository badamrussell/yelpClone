class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.date :birthdate
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :session_token
      t.attachment :profile_photo
      t.integer :reviews_count
      t.integer :photos_count
      t.integer :review_compliments_count

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
