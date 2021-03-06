class Compliment < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :review_compliments,
    class_name: "ReviewCompliment",
    primary_key: :id,
    foreign_key: :compliment_id
  )

  has_many :reviews, through: :review_compliments, source: :compliment

  def self.all_cached
    # @all_compliments ||= Compliment.all
    Compliment.all
  end

  def image_name
  	name.gsub(" ","-").gsub("'","").downcase
  end

end
