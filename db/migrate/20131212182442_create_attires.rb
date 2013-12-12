class CreateAttires < ActiveRecord::Migration
  def change
    create_table :attires do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
