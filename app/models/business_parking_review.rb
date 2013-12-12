class BusinessParkingReview < ActiveRecord::Base
  attr_accessible :business_parking_id, :restaurant_detail_id

  validates :business_parking_id, :restaurant_detail_id, presence: true
end
