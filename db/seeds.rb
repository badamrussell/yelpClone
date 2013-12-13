# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create( [
  {email: "b.ad.russell@gmail.com", password: "123456", first_name: "adam", last_name: "russell"},
  {email: "walt@amc.com", password: "123456", first_name: "walt", last_name: "white"},
  {email: "sponge@bob.com", password: "123456", first_name: "Spongebob", last_name: "Squarepants"}
])
new_bio = UserBio.new()
new_bio.user_id = 1
new_bio.save

new_bio = UserBio.new()
new_bio.user_id = 2
new_bio.save

new_bio = UserBio.new()
new_bio.user_id = 3
new_bio.save

neighborhood = Location.determine_neighborhood()
ProfileLocation.create(user_id: 1, address: neighborhood, name: "Home", primary: true)
ProfileLocation.create(user_id: 2, address: neighborhood, name: "Home", primary: true)
ProfileLocation.create(user_id: 3, address: neighborhood, name: "Home", primary: true)


Business.create(name: "Bob's Burgers", country_id: 1, category1_id: 1, category2_id: 4,category3_id: 7)
Business.create(name: "Cheers", country_id: 1, category1_id: 10, category2_id: 1,category3_id: 2)
Business.create(name: "Chipotle", country_id: 1, category1_id: 12, category2_id: 1,category3_id: 2)

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

Review.create([
  {rating: 3, user_id: 1, business_id: 1, body: "Food was amazing!"},
  {rating: 1, user_id: 2, business_id: 1, body: "Meh. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla mollis euismod velit sit amet iaculis. Nullam lacinia vel felis at tincidunt. Fusce non euismod sem, non mollis lectus. Nunc sed enim et dolor tempus mattis vel ut felis. Sed condimentum eget turpis sed tempor. Aenean varius quis nunc ac convallis. Maecenas feugiat in massa sit amet tincidunt. Fusce dapibus dui nisi, et consequat nisi aliquet at. Aenean mi purus, venenatis eget diam pellentesque, ultrices dictum nisi. Nullam quam lorem, lacinia ac justo nec, varius ullamcorper ligula. Pellentes"},
  {rating: 2, user_id: 3, business_id: 2, body: "Whatever. Iate ther .Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla mollis euismod velit sit amet iaculis. Nullam lacinia vel felis at tincidunt. Fusce non euismod sem, non mollis lectus. Nunc sed enim et dolor tempus mattis vel ut felis. Sed condimentum eget turpis sed tempor. Aenean varius quis nunc ac convallis. Maecenas feugiat in massa sit amet tincidunt. Fusce dapibus dui nisi, et consequat nisi aliquet at. Aenean mi purus, venenatis eget diam pellentesque, entes"},
  {rating: 5, user_id: 1, business_id: 2, body: "el, tempus felis. Nulla pharetra orci sit amet metus volutpat, ut hendrerit metus ornare. Curabitur aliquam vitae augue at feugiat. Maecenas gravida scelerisque tortor sed eleifend. Sed at lorem laoreet velit consectetur dapibus. Vestibulum semper pretium scelerisque. Etiam tempus elit at nisl porttitor egestas. Nunc id tincidunt magna. Interdum et malesuada fames ac ante ipsum primis in"},
  {rating: 4, user_id: 3, business_id: 3, body: " Fusce eu mauris vel nulla posuere mattis sed ac felis. Etiam rhoncus venenatis augue, non posuere enim sollicitudin in. Aliquam sollicitudin nisl ut magna dapibus scelerisque. Pellentesque adipiscing pharetra est ac luctus. Phasellus auctor ac erat in varius.

Quisque id nisl dapibus, consequat nibh vel, tempus"},
  {rating: 5, user_id: 2, business_id: 3, body: "imenaeos. Proin laoreet rutrum justo ac vehicula. Vivamus eros elit, sagittis ultricies auctor et, ultrices sed leo. Vestibulum ligula leo, pharetra in ante nec, faucibus pretium sapien. Duis feugiat bibendum dui, in mattis nisl ultrices ac. Quisque tincidunt eleifend mauris sed volutpat. Donec tincidunt sollicitudin velit, sit amet malesuada lacus semper vestibulum. Sed laci"},
  {rating: 3, user_id: 1, business_id: 3, body: "ontent of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."}
]
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

ProfileLocation.create([
  {user_id: 1, name: "Home", address: "Manhattan, NY", primary: true}
])

Helpful.create([
  {name: "Very Helpful"},
  {name: "Helpful"},
  {name: "Not Helpful"}
])