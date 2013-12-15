class CreateCompliments < ActiveRecord::Migration
  def change
    create_table :compliments do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
