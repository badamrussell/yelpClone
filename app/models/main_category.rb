class MainCategory < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true
  

  def self.restaurantID
  	MainCategory.find_by_name("Restaurants").id
  end
end
