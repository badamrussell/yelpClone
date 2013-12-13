class Photo < ActiveRecord::Base
  attr_accessible :business_id, :img_url, :store_front, :user_id
end
