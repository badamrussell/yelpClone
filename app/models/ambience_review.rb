class AmbienceReview < ActiveRecord::Base
  attr_accessible :ambience_id, :restaurant_detail_id

  validates :ambience_id, :restaurant_detail_id, presence: true
end
