class Follow < ActiveRecord::Base
  attr_accessible :follower_id, :leader_id
end
