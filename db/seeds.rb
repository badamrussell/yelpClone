# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create( email: "b.ad.russell@gmail.com", password: "123456", first_name: "adam", last_name: "russell" )
new_bio = UserBio.new()
new_bio.user_id = 1
new_bio.save

Business.create(name: "Bob's Burgers", country_id: 1, category1: 1, category2: 4,category3: 7)

Category.create([
  {name: "Restaurants"},
  {name: "Food"},
  {name: "Nightlife"},
  {name: "Shopping"},
  {name: "Bars"},
  {name: "American"},
  {name: "Italian"},
  {name: "Lounges"},
  {name: "Beauty & Spas"},
  {name: "Health & Medical"},
  {name: "Local Services"},
  {name: "Home Services"},
  {name: "Autmotive"},
  {name: "Arts & Entertainment"},
  {name: "Event Planning & Services"},
  {name: "Hotels & Travel"},
  {name: "Active Life"},
  {name: "Pets"},
  {name: "Public Services & Government"},
  {name: "Local Flavor"},
  {name: "Education"},
  {name: "Real Estate"},
  {name: "Professional Services"},
  {name: "Financial Services"},
  {name: "Mass Media"},
  {name: "Religious Organizations"}
])

City.create([
  {name: "New York"},
  {name: "San Francisco"},
  {name: "Los Angeles"},
  {name: "San Jose"},
  {name: "Chicago"},
  {name: "Palo Alto"}
])

Location.create([
  {name: "Manhattan", city_id: 1},
  {name: "Bronx", city_id: 1},
  {name: "Queens", city_id: 1},
  {name: "Brooklyn", city_id: 1}
])

Neighborhood.create([
  {name: "Midtown West", location_id: 1},
  {name: "Theater District", location_id: 1},
  {name: "Hell's Kitchen", location_id: 1},
  {name: "Midtown East", location_id: 1}
])

SubCategory.create([
  {name: "Arcades", category_id: 14},
  {name: "Art Galleries", category_id: 14},
  {name: "Botanical Gardens", category_id: 14},
  {name: "Casinos", category_id: 14},
  {name: "Cinema", category_id: 14},
  {name: "Cultural Center", category_id: 14},
  {name: "Festivals", category_id: 14},
  {name: "Jazz & Blues", category_id: 14},
  {name: "Museums", category_id: 14},
  {name: "Music Venues", category_id: 14},
  {name: "Opera & Ballet", category_id: 14},
  {name: "Performing Arts", category_id: 14},
  {name: "Professional Sports Teams", category_id: 14},
  {name: "Psychics & Astrologers", category_id: 14},
  {name: "Race Tracks", category_id: 14},
  {name: "Social Clubs", category_id: 14},
  {name: "Stadiums & Arenas", category_id: 14},
  {name: "Ticket Sales", category_id: 14},
  {name: "Wineries", category_id: 14}
])

Country.create([
  {name: "United States"},
  {name: "United Kingdom"},
  {name: "Germany"},
  {name: "Canada"},
  {name: "Spain"}
])

Decision.create([
  {name: "Yes"},
  {name: "No"},
  {name: "Not Sure"}
])

Ambience.create([
  {name: "Divey"},
  {name: "Hipster"},
  {name: "Casual"},
  {name: "Touristy"},
  {name: "Trendy"},
  {name: "Intimate"},
  {name: "Romantic"},
  {name: "Classy"},
  {name: "Upscale"}
])

BusinessParking.create([
  {name: "Valet"},
  {name: "Garage"},
  {name: "Street"},
  {name: "Private Lot"},
  {name: "Validated"}
])

GoodForMeal.create([
  {name: "Breakfast"},
  {name: "Brunch"},
  {name: "Lunch"},
  {name: "Dinner"},
  {name: "Late Night"},
  {name: "Dessert"}
])

Review.create(
  rating: 3,
  user_id: 1,
  business_id: 1,
  body: "Food was amazing!"
)

Attire.create([
  {name: "Casual"},
  {name: "Dressy"},
  {name: "Formal (Jacket Required)"},
  {name: "Not Sure"},
])

NoiseLevel.create([
  {name: "Quiet"},
  {name: "Average"},
  {name: "Loud"},
  {name: "Very Loud"},
  {name: "Not Sure"}
])