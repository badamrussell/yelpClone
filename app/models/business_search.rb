class BusinessSearch < ActiveRecord::Base
  attr_accessible :business_id, :words

  validates :business_id, numericality: true
end
