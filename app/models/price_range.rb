class PriceRange < ActiveRecord::Base
    attr_accessible :name, :color

    validates :name, :color, presence: true
end
