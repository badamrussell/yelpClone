# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create( [
  {email: "b.ad.russell@gmail.com", password: "123456", first_name: "adam", last_name: "russell", img_url: "/assets/temp/bob-burger.jpg"},
  {email: "walt@amc.com", password: "123456", first_name: "walt", last_name: "white"},
  {email: "sponge@bob.com", password: "123456", first_name: "Spongebob", last_name: "Squarepants", img_url: "/assets/temp/imgres.jpg"}
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

MainCategory.create([
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

Category.create([

  {name: "Afghan", main_category_id: 1},
  {name: "African", main_category_id: 1},
  {name: "Senegalese", main_category_id: 1},
  {name: "South African", main_category_id: 1},
  {name: "American (New)", main_category_id: 1},
  {name: "American (Traditional)", main_category_id: 1},
  {name: "Arabian", main_category_id: 1},
  {name: "Argentine", main_category_id: 1},
  {name: "Armenian", main_category_id: 1},
  {name: "Asian Fusion", main_category_id: 1},
  {name: "Australian", main_category_id: 1},
  {name: "Austrian", main_category_id: 1},
  {name: "Bangladeshi", main_category_id: 1},
  {name: "Barbeque", main_category_id: 1},
  {name: "Basque", main_category_id: 1},
  {name: "Belgian", main_category_id: 1},
  {name: "Brasseries", main_category_id: 1},
  {name: "Brazilian", main_category_id: 1},
  {name: "Breakfast & Brunch", main_category_id: 1},
  {name: "British", main_category_id: 1},
  {name: "Buffets", main_category_id: 1},
  {name: "Burgers", main_category_id: 1},
  {name: "Burmese", main_category_id: 1},
  {name: "Cafes", main_category_id: 1},
  {name: "Cafeteria", main_category_id: 1},
  {name: "Cajun/Creole", main_category_id: 1},
  {name: "Cambodian", main_category_id: 1},
  {name: "Caribbean", main_category_id: 1},
  {name: "Dominican", main_category_id: 1},
  {name: "Haitian", main_category_id: 1},
  {name: "Puerto Rican", main_category_id: 1},
  {name: "Trinidadian", main_category_id: 1},
  {name: "Catalan", main_category_id: 1},
  {name: "Cheesesteaks", main_category_id: 1},
  {name: "Chicken Wings", main_category_id: 1},
  {name: "Chinese", main_category_id: 1},
  {name: "Cantonese", main_category_id: 1},
  {name: "Dim Sum", main_category_id: 1},
  {name: "Shanghainese", main_category_id: 1},
  {name: "Szechuan", main_category_id: 1},
  {name: "Comfort Food", main_category_id: 1},
  {name: "Creperies", main_category_id: 1},
  {name: "Cuban", main_category_id: 1},
  {name: "Czech", main_category_id: 1},
  {name: "Delis", main_category_id: 1},
  {name: "Diners", main_category_id: 1},
  {name: "Ethiopian", main_category_id: 1},
  {name: "Fast Food", main_category_id: 1},
  {name: "Filipino", main_category_id: 1},
  {name: "Fish & Chips", main_category_id: 1},
  {name: "Fondue", main_category_id: 1},
  {name: "Food Court", main_category_id: 1},
  {name: "Food Stands", main_category_id: 1},
  {name: "French", main_category_id: 1},
  {name: "Gastropub", main_category_id: 1},
  {name: "German", main_category_id: 1},
  {name: "Gluten-Free", main_category_id: 1},
  {name: "Greek", main_category_id: 1},
  {name: "Halal", main_category_id: 1},
  {name: "Hawaiian", main_category_id: 1},
  {name: "Himalayan/Nepalese", main_category_id: 1},
  {name: "Hot Dogs", main_category_id: 1},
  {name: "Hot Pot", main_category_id: 1},
  {name: "Hungarian", main_category_id: 1},
  {name: "Iberian", main_category_id: 1},
  {name: "Indian", main_category_id: 1},
  {name: "Indonesian", main_category_id: 1},
  {name: "Irish", main_category_id: 1},
  {name: "Italian", main_category_id: 1},
  {name: "Japanese", main_category_id: 1},
  {name: "Korean", main_category_id: 1},
  {name: "Kosher", main_category_id: 1},
  {name: "Laotian", main_category_id: 1},
  {name: "Latin American", main_category_id: 1},
  {name: "Colombian", main_category_id: 1},
  {name: "Salvadoran", main_category_id: 1},
  {name: "Venezuelan", main_category_id: 1},
  {name: "Live/Raw Food", main_category_id: 1},
  {name: "Malaysian", main_category_id: 1},
  {name: "Mediterranean", main_category_id: 1},
  {name: "Falafel", main_category_id: 1},
  {name: "Mexican", main_category_id: 1},
  {name: "Middle Eastern", main_category_id: 1},
  {name: "Egyptian", main_category_id: 1},
  {name: "Lebanese", main_category_id: 1},
  {name: "Modern European", main_category_id: 1},
  {name: "Mongolian", main_category_id: 1},
  {name: "Moroccan", main_category_id: 1},
  {name: "Pakistani", main_category_id: 1},
  {name: "Persian/Iranian", main_category_id: 1},
  {name: "Peruvian", main_category_id: 1},
  {name: "Pizza", main_category_id: 1},
  {name: "Polish", main_category_id: 1},
  {name: "Portuguese", main_category_id: 1},
  {name: "Russian", main_category_id: 1},
  {name: "Salad", main_category_id: 1},
  {name: "Sandwiches", main_category_id: 1},
  {name: "Scandinavian", main_category_id: 1},
  {name: "Scottish", main_category_id: 1},
  {name: "Seafood", main_category_id: 1},
  {name: "Singaporean", main_category_id: 1},
  {name: "Slovakian", main_category_id: 1},
  {name: "Soul Food", main_category_id: 1},
  {name: "Soup", main_category_id: 1},
  {name: "Southern", main_category_id: 1},
  {name: "Spanish", main_category_id: 1},
  {name: "Steakhouses", main_category_id: 1},
  {name: "Sushi Bars", main_category_id: 1},
  {name: "Taiwanese", main_category_id: 1},
  {name: "Tapas Bars", main_category_id: 1},
  {name: "Tapas/Small Plates", main_category_id: 1},
  {name: "Tex-Mex", main_category_id: 1},
  {name: "Thai", main_category_id: 1},
  {name: "Turkish", main_category_id: 1},
  {name: "Ukrainian", main_category_id: 1},
  {name: "Vegan", main_category_id: 1},
  {name: "Vegetarian", main_category_id: 1},
  {name: "Vietnamese", main_category_id: 1},

  {name: "Arcades", main_category_id: 14},
  {name: "Art Galleries", main_category_id: 14},
  {name: "Botanical Gardens", main_category_id: 14},
  {name: "Casinos", main_category_id: 14},
  {name: "Cinema", main_category_id: 14},
  {name: "Cultural Center", main_category_id: 14},
  {name: "Festivals", main_category_id: 14},
  {name: "Jazz & Blues", main_category_id: 14},
  {name: "Museums", main_category_id: 14},
  {name: "Music Venues", main_category_id: 14},
  {name: "Opera & Ballet", main_category_id: 14},
  {name: "Performing Arts", main_category_id: 14},
  {name: "Professional Sports Teams", main_category_id: 14},
  {name: "Psychics & Astrologers", main_category_id: 14},
  {name: "Race Tracks", main_category_id: 14},
  {name: "Social Clubs", main_category_id: 14},
  {name: "Stadiums & Arenas", main_category_id: 14},
  {name: "Ticket Sales", main_category_id: 14},
  {name: "Wineries", main_category_id: 14},
  {name: "Bagels", main_category_id: 1},
  {name: "Bakeries", main_category_id: 2},
  {name: "Beer, Wine & Spirits", main_category_id: 2},
  {name: "Breweries", main_category_id: 2},
  {name: "Bubble Tea", main_category_id: 2},
  {name: "Butcher", main_category_id: 2},
  {name: "CSA", main_category_id: 2},
  {name: "Coffee & Tea", main_category_id: 2},
  {name: "Convenience Stores", main_category_id: 2},
  {name: "Cupcakes", main_category_id: 2},
  {name: "Desserts", main_category_id: 2},
  {name: "Do-It-Yourself Food", main_category_id: 2},
  {name: "Donuts", main_category_id: 2},
  {name: "Farmers Market", main_category_id: 2},
  {name: "Food Delivery Services", main_category_id: 2},
  {name: "Food Trucks", main_category_id: 2},
  {name: "Gelato", main_category_id: 2},
  {name: "Grocery", main_category_id: 2},
  {name: "Ice Cream & Frozen Yogurt", main_category_id: 2},
  {name: "Internet Cafes", main_category_id: 2},
  {name: "Juice Bars & Smoothies", main_category_id: 2},
  {name: "Pretzels", main_category_id: 2},
  {name: "Shaved Ice", main_category_id: 2},
  {name: "Specialty Food", main_category_id: 2},
  {name: "Candy Stores", main_category_id: 2},
  {name: "Cheese Shops", main_category_id: 2},
  {name: "Chocolatiers & Shops", main_category_id: 2},
  {name: "Ethnic Food", main_category_id: 2},
  {name: "Fruits & Veggies", main_category_id: 2},
  {name: "Health Markets", main_category_id: 2},
  {name: "Herbs & Spices", main_category_id: 2},
  {name: "Meat Shops", main_category_id: 2},
  {name: "Seafood Markets", main_category_id: 2},
  {name: "Street Vendors", main_category_id: 2},
  {name: "Tea Rooms", main_category_id: 2},
  {name: "Wineries", main_category_id: 2}



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

Photo.create([
  {business_id:1, img_url: "/assets/temp/food_1.jpg", user_id:1},
  {business_id:1, img_url: "/assets/temp/front.jpg", user_id:1},
  {business_id:2, img_url: "/assets/temp/food_3.jpg", user_id:2},
  {business_id:1, img_url: "/assets/temp/food_4.jpg", user_id:2},
  {business_id:3, img_url: "/assets/temp/food_5.jpg", user_id:3},
  {business_id:3, img_url: "/assets/temp/food_6.jpg", user_id:3}
])

PhotoDetail.create([
  {helpful_id:1, photo_id:1, store_front: false, user_id:1},
  {helpful_id:2, photo_id:2, store_front: true, user_id:2},
  {helpful_id:3, photo_id:3, store_front: false, user_id:3},
  {helpful_id:2, photo_id:4, store_front: false, user_id:3}
])