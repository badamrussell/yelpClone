class Business < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :country_id ,:name ,:address1 ,:address2 ,:city ,:state ,:zip_code ,:phone_number ,:website ,:rating ,:category1 ,:category2 ,:category3

  validates :name, :country_id, presence: true

end
