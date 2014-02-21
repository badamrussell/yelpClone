# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

user1 = User.create!( email: "guest@example.com", password: "123456", first_name: "Guest", last_name: "Gusterson") )

UserBio.find_by_user_id(user1.id).update_attributes(
    headline: "I'm new here...",
    hometown: "New York, NY",
    reviews: "Because I am a guest!",
    dont_tell: "I love to test project web sites."
)


neighborhood = Area.determine_neighborhood()
ProfileLocation.create!(user_id: user1.id, address: neighborhood, name: "Home", primary: true)

Business.create!(name: "Bob's Burgers", country_id: 1, neighborhood_id: 1, latitude: Area.rand_lat, longitude: Area.rand_long, category1_id: 1, category2_id: 4, category3_id: 7 )
Business.create!(name: "Krusty Burger", country_id: 1, neighborhood_id: 1, latitude: Area.rand_lat, longitude: Area.rand_long, category1_id: 10, category2_id: 1, category3_id: 2 )
Business.create!(name: "The Krusty Krab", country_id: 1, neighborhood_id: 1, latitude: Area.rand_lat, longitude: Area.rand_long, category1_id: 12, category2_id: 1, category3_id: 2 )

# Photo.create!(user_id: user1.id, business_id: 1, file: open("https://s3.amazonaws.com/yolp_seed_images/store_0a.jpg") )

MainCategory.create!([
  {name: "Restaurants"}
])

City.create!([
  {name: "New York"}
])

Area.create!([
  {name: "Manhattan", city_id: 1},
  {name: "Brooklyn", city_id: 1},
  {name: "Queens", city_id: 1},
  {name: "Bronx", city_id: 1},
  {name: "Staten Island", city_id: 1}
])

Neighborhood.create!([
  {name: "Alphabet City", area_id: 1},
  {name: "Battery Park", area_id: 1},
  {name: "Chinatown", area_id: 1},
  {name: "East Village", area_id: 1},
  {name: "Financial District", area_id: 1},
  {name: "Flatiron", area_id: 1},
  {name: "Greenwich Village", area_id: 1},
  {name: "Harlem", area_id: 1},
  {name: "Hell's Kitchen", area_id: 1},
  {name: "Civic Center", area_id: 2},
  {name: "Clark-Fulton", area_id: 2},
  {name: "Collamer", area_id: 2},
  {name: "Stockyards", area_id: 2},
  {name: "The Flats", area_id: 3},
  {name: "Tower City", area_id: 2},
  {name: "Tremont", area_id: 3},
  {name: "Bushwick", area_id: 4},
  {name: "Coney Island", area_id: 4}
])

Category.create!([
  {name: "Afghan", main_category_id: 1},
  {name: "African", main_category_id: 1},
  {name: "Senegalese", main_category_id: 1},
  {name: "Armenian", main_category_id: 1},
  {name: "Asian Fusion", main_category_id: 1},
  {name: "Australian", main_category_id: 1},
  {name: "Austrian", main_category_id: 1},
  {name: "Shanghainese", main_category_id: 1},
  {name: "Szechuan", main_category_id: 1}
])

Country.create!([
  {name: "United States"}
])

Review.create!([
  {rating: 3, user_id: user1.id, business_id: 1, body: "Food was amazing!"}
])

PriceRange.create!([
  {name: "$", description: "$5-10"},
  {name: "$$", description: "$11-30"},
  {name: "$$$", description: "$31-60"},
  {name: "$$$$", description: "$61+"}
])

FeatureCategory.create!([
  {name: "General Features", input_type: 1},
  {name: "Alcohol", input_type: 2},
  {name: "Meals Served", input_type: 2},
  {name: "Music", input_type: 1},
  {name: "Parking", input_type: 2},
  {name: "Wi-Fi", input_type: 1},
  {name: "Smoking", input_type: 1},
  {name: "Ambience", input_type: 2},
  {name: "Attire", input_type: 1},
  {name: "Noise Level", input_type: 1}
])

Feature.create!([
  # { name: "Offering a Deal", feature_category_id: 1 },  #1
  # { name: "Open At:", feature_category_id: 1 },
  # { name: "Open Now:", feature_category_id: 1 },
  { name: "Accepts Credit Cards", feature_category_id: 1 },
  { name: "Delivery", feature_category_id: 1 },
  { name: "Outdoor Seating", feature_category_id: 1 },
  { name: "Good for Groups", feature_category_id: 1 },
  { name: "Good for Kids", feature_category_id: 1 },
  { name: "Take-out", feature_category_id: 1 },
  { name: "Wheelchair Accessible", feature_category_id: 1 },
  { name: "Has TV", feature_category_id: 1 },
  { name: "Liked by 20-somethings:", feature_category_id: 1 },

  { name: "Caters", feature_category_id: 1 }, #10
  { name: "Dogs Allowed", feature_category_id: 1 },
  { name: "Open 24 Hours", feature_category_id: 1 },
  { name: "Order at Counter", feature_category_id: 1 },
  { name: "Takes Reservations", feature_category_id: 1 },
  { name: "Waiter Service", feature_category_id: 1 },

  { name: "Full Bar", feature_category_id: 2 },
  { name: "Happy Hour", feature_category_id: 2 },
  { name: "Beer & Wine Only", feature_category_id: 2 },
  { name: "BYOB", feature_category_id: 2 },
  { name: "Corkage", feature_category_id: 2 }, #20

  { name: "Breakfast", feature_category_id: 3 },
  { name: "Brunch", feature_category_id: 3 },
  { name: "Lunch", feature_category_id: 3 },
  { name: "Dinner", feature_category_id: 3 },
  { name: "Dessert", feature_category_id: 3 },
  { name: "Late Night", feature_category_id: 3 },

  { name: "DJ", feature_category_id: 4 },
  { name: "Jukebox", feature_category_id: 4 },
  { name: "Karaoke", feature_category_id: 4 },
  { name: "Live", feature_category_id: 4 }, #30

  { name: "Street", feature_category_id: 5 },
  { name: "Garage", feature_category_id: 5 },
  { name: "Valet", feature_category_id: 5 },
  { name: "Private-Lot", feature_category_id: 5 },
  { name: "Validated", feature_category_id: 5 },

  { name: "Free", feature_category_id: 6 },
  { name: "Paid", feature_category_id: 6 },

  { name: "Outdoor Area / Patio Only", feature_category_id: 7 },

  { name: "Divey", feature_category_id: 8 },
  { name: "Hipster", feature_category_id: 8 }, #40
  { name: "Casual", feature_category_id: 8 },
  { name: "Touristy", feature_category_id: 8 },
  { name: "Trendy", feature_category_id: 8 },
  { name: "Intimate", feature_category_id: 8 },
  { name: "Romantic", feature_category_id: 8 },
  { name: "Classy", feature_category_id: 8 },
  { name: "Upscale", feature_category_id: 8 },

  { name: "Casual", feature_category_id: 9 },
  { name: "Dressy", feature_category_id: 9 },
  { name: "Formal (Jacket Required)", feature_category_id: 9 },

  { name: "Quiet", feature_category_id: 10 },
  { name: "Average", feature_category_id: 10 },
  { name: "Loud", feature_category_id: 10 },
  { name: "Very Loud", feature_category_id: 10 }
])

Helpful.create!([
  {name: "Very Helpful"},
  {name: "Helpful"},
  {name: "Not Helpful"}
])

Vote.create!([
  {name: "Useful"},
  {name: "Funny"},
  {name: "Cool"}
])

Compliment.create!([
  {name: "Thank You"},
  {name: "Good Writer"},
  {name: "Just a Note"},
  {name: "Write More"},
  {name: "Great Photo"},
  {name: "You're Funny"},
  {name: "Cute Pic"},
  {name: "Hot Stuff"},
  {name: "Like Your Profile"},
  {name: "You're Cool"},
  {name: "Great Lists"}
])

