class CreateBusinessParkings < ActiveRecord::Migration
  def change
    create_table :business_parkings do |t|
      t.string :name

      t.timestamps
    end
  end
end
