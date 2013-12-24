class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
    	t.integer :business_id, null: false
    	t.integer :day_id, null: false
    	t.integer :time_close, null: false
    	t.integer :time_open, null: false

      t.timestamps
    end

    add_index :business_hours, :business_id
  end
end
