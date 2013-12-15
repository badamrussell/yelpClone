class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :fan_id, null: false
      t.integer :leader_id, null: false

      t.timestamps
    end

    add_index :follows, :fan_id
    add_index :follows, :leader_id

  end
end
