class CreateBusinessParkingReviews < ActiveRecord::Migration
  def change
    create_table :business_parking_reviews do |t|

      t.timestamps
    end
  end
end
