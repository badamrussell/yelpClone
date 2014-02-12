module GoogleMap

  def self.determine_bounds(center, miles_offset)
    # calculates ne and sw corner
    # SW-74.069, 40.710
    # NE -73.86, 40.866

    lng_offset = miles_offset / 69.0
    lat_offset = miles_offset / 53.0
    bounds = []
    bounds << center[:lat] - lat_offset
    bounds << center[:lng] + lng_offset
    bounds << center[:lat] + lat_offset
    bounds << center[:lng] - lng_offset

    bounds
  end

  def self.get_map(center, width, height)
    icon_location = "https://s3.amazonaws.com/kelp_dev/pin.png"
    str_center = "#{center['lat']}, #{center['lng']}"
    marker = []
    Addressable::URI.new(
      scheme: "https",
      host: "maps.googleapis.com",
      path: "maps/api/staticmap",
      query_values: {
        scale: 1,
        center: str_center,
        language: "en",
        zoom: "14",
        size: "#{width}x#{height}",
        markers: "scale:1|shadow:true|icon:#{icon_location}|#{center}",
        sensor: "false"
      }
    ).to_s
  end

  def self.get_half_map(center)
    icon_location = "https://s3.amazonaws.com/kelp_dev/pin.png"
    str_center = "#{center['lat']}, #{center['lng']}"
    marker = []
    Addressable::URI.new(
      scheme: "https",
      host: "maps.googleapis.com",
      path: "maps/api/staticmap",
      query_values: {
        scale: 1,
        center: str_center,
        language: "en",
        zoom: "14",
        size: "286x135",
        markers: "scale:1|shadow:true|icon:#{icon_location}|#{center}",
        sensor: "false"
      }
    ).to_s
  end

  def self.find_nearby(latitude, longitude, keywords="")
    Addressable::URI.new(
      scheme: "https",
      host: "maps.googleapis.com",
      # path: "place/nearbysearch/json",
      path: "maps/api/place/nearbysearch/json",
      query_values: {
        key: ENV["GOOGLE_API_KEY"],
        location: "#{latitude},#{longitude}",
        keyword: keywords,
        type: "restaurant",
        radius: 2000,
        sensor: "false"
      }
    ).to_s

    response = RestClient.get(address.to_s)

    places = JSON.parse(response)["results"].map do |place|
      { location: place["geometry"]["location"],
        street_address: place["vicinity"],
        name: place["name"]
      }
    end

  end
end