class RestaurantDetail < ActiveRecord::Base
  attr_accessible :review_id, :good_for_groups, :noise_level, :price_range, :attire, :good_for_kids, :wifi, :drive_thru, :has_tv, :caters

  validates :review_id, presence: true
end
