class PriceRange < ActiveRecord::Base
    attr_accessible :name, :color, :description

    validates :name, :color, :description, presence: true
end
