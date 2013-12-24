class GoogleMap

  def self.static_map(center)
    marker = []
    Addressable::URI.new(
      scheme: "https",
      host: "maps.googleapis.com",
      path: "maps/api/staticmap",
      query_values: {
        center: center,
        zoom: "13",
        size: "200x200",
        sensor: "false",
        markers: "scale:1|shadow:false|icon:#{icon_location}|#{center}"
      }
    ).to_s
  end
end

# https://maps.googleapis.com/maps/api/staticmap?parameters
#
# center
# zoom
#
# size
# visual_refresh
# scale
# format
# maptype
# language
# region
#
# markers
# path
# visible
# style
#
# sensor
#
#
# lat -90 => 90
# long -180 =< 180
#
#
# https://maps.googleapis.com/maps/api/staticmap?center=51.477222,0
#
# markers=
#
# http://maps.google.com/maps/api/staticmap?
# scale=1&
# center=40.765274%2C-73.988055&
# language=en&
# zoom=15&
# markers=  scale%3A1%7C
#           shadow%3Afalse%7C
#           icon%3Ahttp%3A%2F%2Fyelp-images.s3.amazonaws.com%2Fassets%2Fmap-markers%2Fannotation_2x.png%7C
#           40.765274%2C-73.988055&
# client=gme-yelp&
# sensor=false&
# size=286x135&
# signature=oKs7mj34dmhlDETm5eFaWNd8Ebk=

# https://maps.googleapis.com/maps/api/staticmap?
# center=251.477222%2C0&
# markers=scale%3A1%7C
#         shadow%3Afalse%7C
#         icon%3Ahttps%3A%2F%2Fs3.amazonaws.com%2Fkelp_dev%2Fpin.png%7C251.477222%2C0&
# sensor=false&
# size=200x200&
# zoom=13

class MapAPI < ActiveRecord::Base
  def self.random_ny_gps
    "40.#{rand(100000)},-73.#{rand(100000)}"
  end
end