module ApplicationHelper

  def get_static_map(center)
    icon_location = "https://s3.amazonaws.com/kelp_dev/pin.png"
    marker = []
    Addressable::URI.new(
      scheme: "https",
      host: "maps.googleapis.com",
      path: "maps/api/staticmap",
      query_values: {
        scale: 1,
        center: center,
        language: "en",
        zoom: "13",
        size: "200x200",
        markers: "scale:1|shadow:true|icon:#{icon_location}|#{center}",
        sensor: "false"
      }
    ).to_s
  end

  def get_half_map(center)
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

  def random_ny_gps
    "40.5#{rand(1000)},-73.4#{rand(1000)}"
  end

  def find_nearby(latitude, longitude, keywords="")
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
