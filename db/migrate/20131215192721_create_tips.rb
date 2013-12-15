class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :body, null: false
      t.integer :user_id, null: false
      t.integer :business_id, null: false

      t.timestamps
    end

    add_index :tips, :user_id
    add_index :tips, :business_id
  end
end
