class Review < ActiveRecord::Base
  attr_accessible :rating, :user_id, :business_id, :body

  validates :rating, :user_id, :business_id, :body, presence: true
end
