class PriceRange < ActiveRecord::Base
  attr_accessible :name, :description

  default_scope order("id ASC")

end
