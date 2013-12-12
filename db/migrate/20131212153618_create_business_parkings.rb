class CreateBusinessParkings < ActiveRecord::Migration
  def change
    create_table :business_parkings do |t|

      t.timestamps
    end
  end
end
