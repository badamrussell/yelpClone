class Business < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :country_id ,:name ,:address1 ,:address2 ,:city ,:state ,:zip_code ,:phone_number ,:website ,:rating ,:category1_id ,:category2_id ,:category3_id

  validates :name, :country_id, presence: true

  belongs_to(
    :country,
    class_name: "Country",
    primary_key: :id,
    foreign_key: :country_id
  )

  has_many(
    :reviews,
    class_name: "Review",
    primary_key: :id,
    foreign_key: :business_id
  )



  def self.best(categoryID)
    Business.all[0..5]
  end

  def store_front_photo
    "/assets/temp/photo_med_square.jpg"
  end

  def photos
    [1,2,3,4,5,6,7]
  end



end
