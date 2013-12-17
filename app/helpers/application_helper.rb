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
        size: "286x135",
        markers: "scale:1|shadow:true|icon:#{icon_location}|#{center}",
        sensor: "false"
      }
    ).to_s
  end

  def random_ny_gps
    "40.#{rand(100000)},-73.#{rand(100000)}"
  end
end
