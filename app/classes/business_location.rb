module BusinessLocation
  extend ActiveSupport::Concern

  included do
    geocoded_by :full_street_address
    after_validation :geocode

    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode

    before_validation :set_neighborhood


    belongs_to(
      :country,
      class_name: "Country",
      primary_key: :id,
      foreign_key: :country_id
    )

    belongs_to(
      :neighborhood,
      class_name: "Neighborhood",
      primary_key: :id,
      foreign_key: :neighborhood_id
    )
  end
  

  module InstanceMethods
    def full_street_address
      a1 = address1 || ""
      a2 = address2 || ""
      c1 = city || ""
      s1 = state || ""
      z1 = zip_code || ""

      "#{a1} #{a2} #{c1}, #{s1} #{z1}"
    end

    def set_neighborhood
      self.neighborhood_id = Neighborhood.random_neighborhood(1) unless self.neighborhood_id
    end

    def address=(arg)
      addr = arg.split(",").map { |a| a.strip }
      self.address1 = addr[0]
      self.city = addr[1]
      self.state = addr[2].split(" ")[0]
      self.zip_code = addr[2].split(" ")[1].to_i
    end

    def gps
      { lat: latitude, lng: longitude }
    end

    def location
      [{ type: "point", lat: latitude, lon: longitude }]
    end
  end

end