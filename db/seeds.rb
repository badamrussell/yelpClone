# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

random_reviews = File.readlines("app/assets/images/random_reviews.txt").to_a

user1 = User.create!( email: "guest@example.com", password: "123456", first_name: "Guest", last_name: "Gusterson", profile_photo: open("#{ENV['SEED_IMAGE_URL']}/user_0.jpg") )
user2 = User.create!( email: "walt@amc.com", password: "123456", first_name: "walt", last_name: "white", profile_photo: open("#{ENV['SEED_IMAGE_URL']}/user_1.jpg")  )
user3 = User.create!( email: "sponge@bob.com", password: "123456", first_name: "Spongebob", last_name: "Squarepants", profile_photo: open("#{ENV['SEED_IMAGE_URL']}/user_2.jpg") )
user4 = User.create!( email: "frink@example.com", password: "123456", first_name: "John", last_name: "Frink", profile_photo: open("#{ENV['SEED_IMAGE_URL']}/user_3.jpg") )

UserBio.find_by_user_id(user1.id).update_attributes(
    headline: "I'm new here...",
    hometown: "New York, NY",
    reviews: "Because I am a guest!",
    dont_tell: "I love to test project web sites."
)
UserBio.find_by_user_id(user2.id).update_attributes(
    headline: "I'm new here...",
    hometown: "Albuquerque, NM",
    reviews: "No Half Measures.",
    dont_tell: "I used to be a high school chemistry teacher."
)
UserBio.find_by_user_id(user3.id).update_attributes(
    headline: "I'm new here...",
    hometown: "Bikini Bottom",
    reviews: "We've been smeckledorfed!",
    dont_tell: "Well, it's no secret that the best thing about a secret is secretly telling someone your secret..."
)
UserBio.find_by_user_id(user4.id).update_attributes(
    headline: "I'm new here...",
    hometown: "Springfield, OR",
    reviews: "Ah, for glavin out loud...",
    dont_tell: "This sarcasm detector is off the charts!"
)

neighborhood = Area.determine_neighborhood()
ProfileLocation.create!(user_id: user1.id, address: neighborhood, name: "Home", primary: true)
ProfileLocation.create!(user_id: user2.id, address: neighborhood, name: "Home", primary: true)
ProfileLocation.create!(user_id: user3.id, address: neighborhood, name: "Home", primary: true)
ProfileLocation.create!(user_id: user4.id, address: neighborhood, name: "Home", primary: true)

Business.create!(name: "Bob's Burgers", country_id: 1, neighborhood_id: 1, latitude: Area.rand_lat, longitude: Area.rand_long, category1_id: 1, category2_id: 4, category3_id: 7 )
Business.create!(name: "Krusty Burger", country_id: 1, neighborhood_id: 1, latitude: Area.rand_lat, longitude: Area.rand_long, category1_id: 10, category2_id: 1, category3_id: 2 )
Business.create!(name: "The Krusty Krab", country_id: 1, neighborhood_id: 1, latitude: Area.rand_lat, longitude: Area.rand_long, category1_id: 12, category2_id: 1, category3_id: 2 )

Photo.create!(user_id: user1.id, business_id: 1, file: open("https://s3.amazonaws.com/yolp_seed_images/store_0a.jpg") )
Photo.create!(user_id: user2.id, business_id: 2, file: open("https://s3.amazonaws.com/yolp_seed_images/store_0c.jpg") )
Photo.create!(user_id: user3.id, business_id: 3, file: open("https://s3.amazonaws.com/yolp_seed_images/store_0b.jpg") )
Photo.create!(user_id: user4.id, business_id: 1, file: open("https://s3.amazonaws.com/yolp_seed_images/food_39.jpg") )
Photo.create!(user_id: user4.id, business_id: 2, file: open("https://s3.amazonaws.com/yolp_seed_images/food_30.jpg") )
Photo.create!(user_id: user4.id, business_id: 3, file: open("https://s3.amazonaws.com/yolp_seed_images/food_15.jpg") )

# BusinessCategory.create!([
#   {business_id: 1, category_id: 1},
#   {business_id: 1, category_id: 4},
#   {business_id: 1, category_id: 7},

#   {business_id: 2, category_id: 10},
#   {business_id: 2, category_id: 1},
#   {business_id: 2, category_id: 2},

#   {business_id: 3, category_id: 12},
#   {business_id: 3, category_id: 1},
#   {business_id: 3, category_id: 2},

#   {business_id: 4, category_id: 20},
#   {business_id: 4, category_id: 8},
#   {business_id: 4, category_id: 12}
# ])

MainCategory.create!([
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

City.create!([
  {name: "New York"},
  {name: "San Francisco"},
  {name: "Los Angeles"},
  {name: "San Jose"},
  {name: "Chicago"},
  {name: "Palo Alto"}
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
  {name: "Chelsea", area_id: 1},
  {name: "Chinatown", area_id: 1},
  {name: "Civic Center", area_id: 1},
  {name: "East Harlem", area_id: 1},
  {name: "East Village", area_id: 1},
  {name: "Financial District", area_id: 1},
  {name: "Flatiron", area_id: 1},
  {name: "Gramercy", area_id: 1},
  {name: "Greenwich Village", area_id: 1},
  {name: "Harlem", area_id: 1},
  {name: "Hell's Kitchen", area_id: 1},
  {name: "Inwood", area_id: 1},
  {name: "Kips Bay", area_id: 1},
  {name: "Koreatown", area_id: 1},
  {name: "Little Italy", area_id: 1},
  {name: "Lower East Side", area_id: 1},
  {name: "Manhattan Valley", area_id: 1},
  {name: "Marble Hill", area_id: 1},
  {name: "Meatpacking District", area_id: 1},
  {name: "Midtown East", area_id: 1},
  {name: "Midtown West", area_id: 1},
  {name: "Morningside Heights", area_id: 1},
  {name: "Murray Hill", area_id: 1},
  {name: "NoHo", area_id: 1},
  {name: "Nolita", area_id: 1},
  {name: "Roosevelt Island", area_id: 1},
  {name: "SoHo", area_id: 1},
  {name: "South Street Seaport", area_id: 1},
  {name: "South Village", area_id: 1},
  {name: "Stuyvesant Town", area_id: 1},
  {name: "Theater District", area_id: 1},
  {name: "TriBeCa", area_id: 1},
  {name: "Two Bridges", area_id: 1},
  {name: "Union Square", area_id: 1},
  {name: "Upper East Side", area_id: 1},
  {name: "Upper West Side", area_id: 1},
  {name: "Washington Heights", area_id: 1},
  {name: "West Village", area_id: 1},
  {name: "Yorkville", area_id: 1},
  {name: "Brooklyn Acres", area_id: 2},
  {name: "Brooklyn-Centre", area_id: 2},
  {name: "Carlyon", area_id: 2},
  {name: "Cascade Crossing", area_id: 2},
  {name: "Central", area_id: 2},
  {name: "Chinatown", area_id: 2},
  {name: "Civic Center", area_id: 2},
  {name: "Clark-Fulton", area_id: 2},
  {name: "Collamer", area_id: 2},
  {name: "Cudell", area_id: 2},
  {name: "Detroit-Shoreway", area_id: 2},
  {name: "East 185th", area_id: 2},
  {name: "East Bank", area_id: 2},
  {name: "East Cleveland", area_id: 2},
  {name: "Edgewater", area_id: 2},
  {name: "Euclid-Green", area_id: 2},
  {name: "Fairfax", area_id: 2},
  {name: "Forrest Hill", area_id: 2},
  {name: "Gateway District", area_id: 2},
  {name: "Glenville", area_id: 2},
  {name: "Goodrich Kirtland", area_id: 2},
  {name: "Highland", area_id: 2},
  {name: "Hough", area_id: 2},
  {name: "Industrial Valley", area_id: 2},
  {name: "Jefferson", area_id: 2},
  {name: "Kinsman", area_id: 2},
  {name: "North Broadway", area_id: 2},
  {name: "North Collinwood", area_id: 2},
  {name: "Northeast District", area_id: 2},
  {name: "Northeast Shores", area_id: 2},
  {name: "Ohio City", area_id: 2},
  {name: "Old Brooklyn", area_id: 2},
  {name: "Playhouse Square", area_id: 2},
  {name: "Puritas-Longmead", area_id: 2},
  {name: "Quadrangle", area_id: 2},
  {name: "Ridge & Memphis", area_id: 2},
  {name: "Riverside", area_id: 2},
  {name: "Scranton Peninsula", area_id: 2},
  {name: "South Broadway", area_id: 2},
  {name: "South Collinwood", area_id: 2},
  {name: "St Clair-Superior", area_id: 2},
  {name: "Stockyards", area_id: 2},
  {name: "The Flats", area_id: 2},
  {name: "Tower City", area_id: 2},
  {name: "Tremont", area_id: 2},
  {name: "University", area_id: 2},
  {name: "Warehouse District", area_id: 2},
  {name: "West Bank", area_id: 2},
  {name: "West Boulevard", area_id: 2},
  {name: "Whiskey Island", area_id: 2},
  {name: "Windemere", area_id: 2},
  {name: "Arverne", area_id: 3},
  {name: "Astoria", area_id: 3},
  {name: "Astoria Heights", area_id: 3},
  {name: "Auburndale", area_id: 3},
  {name: "Bay Terrace", area_id: 3},
  {name: "Bayside", area_id: 3},
  {name: "Beechurst", area_id: 3},
  {name: "Bellaire", area_id: 3},
  {name: "Belle Harbor", area_id: 3},
  {name: "Bellerose", area_id: 3},
  {name: "Breezy Point", area_id: 3},
  {name: "Briarwood", area_id: 3},
  {name: "Cambria Heights", area_id: 3},
  {name: "College Point", area_id: 3},
  {name: "Douglaston", area_id: 3},
  {name: "Downtown Flushing", area_id: 3},
  {name: "East Elmhurst", area_id: 3},
  {name: "Edgemere", area_id: 3},
  {name: "Elmhurst", area_id: 3},
  {name: "Far Rockaway", area_id: 3},
  {name: "Floral Park", area_id: 3},
  {name: "Flushing", area_id: 3},
  {name: "Flushing Meadows", area_id: 3},
  {name: "Forest Hills", area_id: 3},
  {name: "Fresh Meadows", area_id: 3},
  {name: "Glen Oaks", area_id: 3},
  {name: "Glendale", area_id: 3},
  {name: "Hillcrest", area_id: 3},
  {name: "Hollis", area_id: 3},
  {name: "Holliswood", area_id: 3},
  {name: "Howard Beach", area_id: 3},
  {name: "Hunters Point", area_id: 3},
  {name: "JFK Airport", area_id: 3},
  {name: "Jackson Heights", area_id: 3},
  {name: "Jamaica", area_id: 3},
  {name: "Jamaica Estates", area_id: 3},
  {name: "Jamaica Hills", area_id: 3},
  {name: "Kew Gardens", area_id: 3},
  {name: "Kew Gardens Hills", area_id: 3},
  {name: "LaGuardia Airport", area_id: 3},
  {name: "Laurelton", area_id: 3},
  {name: "LeFrak City", area_id: 3},
  {name: "Lindenwood", area_id: 3},
  {name: "Little Neck", area_id: 3},
  {name: "Long Island City", area_id: 3},
  {name: "Malba", area_id: 3},
  {name: "Maspeth", area_id: 3},
  {name: "Middle Village", area_id: 3},
  {name: "Murray Hill", area_id: 3},
  {name: "North Corona", area_id: 3},
  {name: "Oakland Gardens", area_id: 3},
  {name: "Ozone Park", area_id: 3},
  {name: "Pomonok", area_id: 3},
  {name: "Queens Village", area_id: 3},
  {name: "Queensborough Hill", area_id: 3},
  {name: "Rego Park", area_id: 3},
  {name: "Richmond Hill", area_id: 3},
  {name: "Ridgewood", area_id: 3},
  {name: "Rochdale", area_id: 3},
  {name: "Rockaway Park", area_id: 3},
  {name: "Rosedale", area_id: 3},
  {name: "Seaside", area_id: 3},
  {name: "Somerville", area_id: 3},
  {name: "Springfield Gardens", area_id: 3},
  {name: "Steinway", area_id: 3},
  {name: "Sunnyside", area_id: 3},
  {name: "Utopia", area_id: 3},
  {name: "Whitestone", area_id: 3},
  {name: "Woodhaven", area_id: 3},
  {name: "Woodside", area_id: 3},
  {name: "Baychester", area_id: 4},
  {name: "Bedford Park", area_id: 4},
  {name: "Belmont", area_id: 4},
  {name: "Castle Hill", area_id: 4},
  {name: "City Island", area_id: 4},
  {name: "Claremont Village", area_id: 4},
  {name: "Clason Point", area_id: 4},
  {name: "Co-op City", area_id: 4},
  {name: "Concourse", area_id: 4},
  {name: "Concourse Village", area_id: 4},
  {name: "Country Club", area_id: 4},
  {name: "East Tremont", area_id: 4},
  {name: "Eastchester", area_id: 4},
  {name: "Edenwald", area_id: 4},
  {name: "Edgewater Park", area_id: 4},
  {name: "Fieldston", area_id: 4},
  {name: "Fordham", area_id: 4},
  {name: "High Bridge", area_id: 4},
  {name: "Hunts Point", area_id: 4},
  {name: "Kingsbridge", area_id: 4},
  {name: "Longwood", area_id: 4},
  {name: "Melrose", area_id: 4},
  {name: "Morris Heights", area_id: 4},
  {name: "Morris Park", area_id: 4},
  {name: "Morrisania", area_id: 4},
  {name: "Mott Haven", area_id: 4},
  {name: "Mount Eden", area_id: 4},
  {name: "Mount Hope", area_id: 4},
  {name: "North Riverdale", area_id: 4},
  {name: "Norwood", area_id: 4},
  {name: "Olinville", area_id: 4},
  {name: "Parkchester", area_id: 4},
  {name: "Pelham Bay", area_id: 4},
  {name: "Pelham Gardens", area_id: 4},
  {name: "Port Morris", area_id: 4},
  {name: "Riverdale", area_id: 4},
  {name: "Schuylerville", area_id: 4},
  {name: "Soundview", area_id: 4},
  {name: "Spuyten Duyvil", area_id: 4},
  {name: "Throgs Neck", area_id: 4},
  {name: "Unionport", area_id: 4},
  {name: "University Heights", area_id: 4},
  {name: "Van Nest", area_id: 4},
  {name: "Wakefield", area_id: 4},
  {name: "West Farms", area_id: 4},
  {name: "Westchester Square", area_id: 4},
  {name: "Williamsbridge", area_id: 4},
  {name: "Woodlawn", area_id: 4},
  {name: "Brooklyn", area_id: 4},
  {name: "Bath Beach", area_id: 4},
  {name: "Bay Ridge", area_id: 4},
  {name: "Bedford Stuyvesant", area_id: 4},
  {name: "Bensonhurst", area_id: 4},
  {name: "Bergen Beach", area_id: 4},
  {name: "Boerum Hill", area_id: 4},
  {name: "Borough Park", area_id: 4},
  {name: "Brighton Beach", area_id: 4},
  {name: "Brooklyn Heights", area_id: 4},
  {name: "Brownsville", area_id: 4},
  {name: "Bushwick", area_id: 4},
  {name: "Canarsie", area_id: 4},
  {name: "Carroll Gardens", area_id: 4},
  {name: "City Line", area_id: 4},
  {name: "Clinton Hill", area_id: 4},
  {name: "Cobble Hill", area_id: 4},
  {name: "Columbia Street Waterfront District", area_id: 4},
  {name: "Coney Island", area_id: 4},
  {name: "Crown Heights", area_id: 4},
  {name: "Cypress Hills", area_id: 4},
  {name: "DUMBO", area_id: 4},
  {name: "Ditmas Park", area_id: 4},
  {name: "Downtown Brooklyn", area_id: 4},
  {name: "Dyker Heights", area_id: 4},
  {name: "East Flatbush", area_id: 4},
  {name: "East New York", area_id: 4},
  {name: "East Williamsburg", area_id: 4},
  {name: "Flatbush", area_id: 4},
  {name: "Flatlands", area_id: 4},
  {name: "Fort Greene", area_id: 4},
  {name: "Fort Hamilton", area_id: 4},
  {name: "Georgetown", area_id: 4},
  {name: "Gerritson Beach", area_id: 4},
  {name: "Gowanus", area_id: 4},
  {name: "Gravesend", area_id: 4},
  {name: "Greenpoint", area_id: 4},
  {name: "Highland Park", area_id: 4},
  {name: "Kensington", area_id: 4},
  {name: "Manhattan Beach", area_id: 4},
  {name: "Marine Park", area_id: 4},
  {name: "Midwood", area_id: 4},
  {name: "Mill Basin", area_id: 4},
  {name: "Mill Island", area_id: 4},
  {name: "New Lots", area_id: 4},
  {name: "Ocean Hill", area_id: 4},
  {name: "Ocean Parkway", area_id: 4},
  {name: "Paedergat Basin", area_id: 4},
  {name: "Park Slope", area_id: 4},
  {name: "Prospect Heights", area_id: 4},
  {name: "Prospect Lefferts Gardens", area_id: 4},
  {name: "Prospect Park South", area_id: 4},
  {name: "Red Hook", area_id: 4},
  {name: "Remsen Village", area_id: 4},
  {name: "Sea Gate", area_id: 4},
  {name: "Sheepshead Bay", area_id: 4},
  {name: "South Slope", area_id: 4},
  {name: "South Williamsburg", area_id: 4},
  {name: "Spring Creek", area_id: 4},
  {name: "Starret City", area_id: 4},
  {name: "Sunset Park", area_id: 4},
  {name: "Vinegar Hill", area_id: 4},
  {name: "Weeksville", area_id: 4},
  {name: "Williamsburg - North Side", area_id: 4},
  {name: "Williamsburg - South Side", area_id: 4},
  {name: "Windsor Terrace", area_id: 4},
  {name: "Wingate", area_id: 4},
  {name: "Annadale", area_id: 5},
  {name: "Arden Heights", area_id: 5},
  {name: "Arlington", area_id: 5},
  {name: "Arrochar", area_id: 5},
  {name: "Bay Terrace", area_id: 5},
  {name: "Bloomfield", area_id: 5},
  {name: "Bullshead", area_id: 5},
  {name: "Castleton Corners", area_id: 5},
  {name: "Charleston", area_id: 5},
  {name: "Chelsea", area_id: 5},
  {name: "Clifton", area_id: 5},
  {name: "Concord", area_id: 5},
  {name: "Dongan Hills", area_id: 5},
  {name: "Elm Park", area_id: 5},
  {name: "Eltingville", area_id: 5},
  {name: "Emerson Hill", area_id: 5},
  {name: "Graniteville", area_id: 5},
  {name: "Grant City", area_id: 5},
  {name: "Grasmere", area_id: 5},
  {name: "Great Kills", area_id: 5},
  {name: "Grymes Hill", area_id: 5},
  {name: "Heartland Village", area_id: 5},
  {name: "Howland Hook", area_id: 5},
  {name: "Huguenot", area_id: 5},
  {name: "Lighthouse Hill", area_id: 5},
  {name: "Mariner", area_id: 5},
  {name: "Midland Beach", area_id: 5},
  {name: "New Brighton", area_id: 5},
  {name: "New Dorp", area_id: 5},
  {name: "New Dorp Beach", area_id: 5},
  {name: "New Springville", area_id: 5},
  {name: "Oakwood", area_id: 5},
  {name: "Old Town", area_id: 5},
  {name: "Park Hill", area_id: 5},
  {name: "Pleasant Plains", area_id: 5},
  {name: "Port Richmond", area_id: 5},
  {name: "Princes Bay", area_id: 5},
  {name: "Randall Manor", area_id: 5},
  {name: "Richmond Town", area_id: 5},
  {name: "Richmond Valley", area_id: 5},
  {name: "Rosebank", area_id: 5},
  {name: "Rossville", area_id: 5},
  {name: "Shore Acres", area_id: 5},
  {name: "Silver Lake", area_id: 5},
  {name: "St. George", area_id: 5},
  {name: "Stapleton", area_id: 5},
  {name: "Sunnyside", area_id: 5},
  {name: "Todt Hill", area_id: 5},
  {name: "Tompkinsville", area_id: 5},
  {name: "Tottenville", area_id: 5},
  {name: "West Brighton", area_id: 5},
  {name: "Westerleigh", area_id: 5},
  {name: "Woodrow", area_id: 5}
])


(4..51).each do |index|
  user = User.create!( email: Faker::Internet.email,
                      password: "123456",
                      first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      profile_photo: open("https://s3.amazonaws.com/yolp_seed_images/user_#{index}.jpg")
                    )
  UserBio.find_by_user_id(user.id).update_attributes(
    headline: Faker::Lorem.sentence,
    hometown: Faker::Address.city,
    reviews: Faker::Lorem.sentence,
    book: Faker::Lorem.words,
    dont_tell: Faker::Lorem.sentence
  )
end

# open_times = [6.hours, 7.5.hours.to_i, 8.hours, 9.hours, 7.5.hours.to_i]
# close_times = [17.hours, 18.5.hours.to_i, 19.hours, 19.5.hours.to_i]

# (1..3).each do |i|
#   avail_days = [0,1,2,3,4,5,6]

#   5.times do
#     d = avail_days.shuffle!.pop
#     BusinessHour.create!( business_id: i, day_id: d, time_close: close_times[rand(3)], time_open: open_times[rand(3)] )
#   end

# end


5.times do |i|
  rand1 = rand(1..30)
  rand2 = rand(31..60)
  rand3 = rand(61..100)

  b = Business.create!( {  name: Faker::Company.name,
                          country_id: 1,
                          phone_number: Faker::PhoneNumber.phone_number,
                          neighborhood_id: rand(1..50),
                          latitude: Area.rand_lat,
                          longitude: Area.rand_long,
                          category1_id: rand1,
                          category2_id: rand2,
                          category3_id: rand3
                        } )

  

  # BusinessCategory.create!([
  #   { business_id: b.id, category_id: rand1 },
  #   { business_id: b.id, category_id: rand2 },
  #   { business_id: b.id, category_id: rand3 }
  # ])

  # avail_days = [0,1,2,3,4,5,6]


  # 5.times do
  #   d = avail_days.shuffle!.pop
  #   BusinessHour.create!( business_id: b.id, day_id: d, time_close: close_times[rand(3)], time_open: open_times[rand(3)] )
  # end


  Photo.create!(user_id: rand(user1.id..(user1.id+50)), business_id: i+3, file: open("https://s3.amazonaws.com/yolp_seed_images/store_#{rand(1..43)}.jpg"))
end





Category.create!([

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
  {name: "British", main_category_id: 1},
  {name: "Buffets", main_category_id: 1},
  {name: "Burgers", main_category_id: 1},
  {name: "Burmese", main_category_id: 1},
  {name: "Cafes", main_category_id: 1},
  {name: "Cafeteria", main_category_id: 1},
  {name: 'Cajun/Creole', main_category_id: 1},
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
  {name: 'Live/Raw Food', main_category_id: 1},
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
  {name: 'Persian/Iranian', main_category_id: 1},
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










Country.create!([
  {name: "United States"},
  {name: "United Kingdom"},
  {name: "Germany"},
  {name: "Canada"},
  {name: "Spain"}
])




Review.create!([
  {rating: 3, user_id: user1.id, business_id: 1, body: "Food was amazing!"},
  {rating: 1, user_id: user2.id, business_id: 1, body: "Meh. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla mollis euismod velit sit amet iaculis. Nullam lacinia vel felis at tincidunt. Fusce non euismod sem, non mollis lectus. Nunc sed enim et dolor tempus mattis vel ut felis. Sed condimentum eget turpis sed tempor. Aenean varius quis nunc ac convallis. Maecenas feugiat in massa sit amet tincidunt. Fusce dapibus dui nisi, et consequat nisi aliquet at. Aenean mi purus, venenatis eget diam pellentesque, ultrices dictum nisi. Nullam quam lorem, lacinia ac justo nec, varius ullamcorper ligula. Pellentes"},
  {rating: 2, user_id: user3.id, business_id: 2, body: "Whatever. I ate there .Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla mollis euismod velit sit amet iaculis. Nullam lacinia vel felis at tincidunt. Fusce non euismod sem, non mollis lectus. Nunc sed enim et dolor tempus mattis vel ut felis. Sed condimentum eget turpis sed tempor. Aenean varius quis nunc ac convallis. Maecenas feugiat in massa sit amet tincidunt. Fusce dapibus dui nisi, et consequat nisi aliquet at. Aenean mi purus, venenatis eget diam pellentesque, entes"},
  {rating: 5, user_id: user1.id, business_id: 2, body: "el, tempus felis. Nulla pharetra orci sit amet metus volutpat, ut hendrerit metus ornare. Curabitur aliquam vitae augue at feugiat. Maecenas gravida scelerisque tortor sed eleifend. Sed at lorem laoreet velit consectetur dapibus. Vestibulum semper pretium scelerisque. Etiam tempus elit at nisl porttitor egestas. Nunc id tincidunt magna. Interdum et malesuada fames ac ante ipsum primis in"},
  {rating: 4, user_id: user3.id, business_id: 3, body: " Fusce eu mauris vel nulla posuere mattis sed ac felis. Etiam rhoncus venenatis augue, non posuere enim sollicitudin in. Aliquam sollicitudin nisl ut magna dapibus scelerisque. Pellentesque adipiscing pharetra est ac luctus. Phasellus auctor ac erat in varius.
Quisque id nisl dapibus, consequat nibh vel, tempus"},
  {rating: 5, user_id: user2.id, business_id: 3, body: "imenaeos. Proin laoreet rutrum justo ac vehicula. Vivamus eros elit, sagittis ultricies auctor et, ultrices sed leo. Vestibulum ligula leo, pharetra in ante nec, faucibus pretium sapien. Duis feugiat bibendum dui, in mattis nisl ultrices ac. Quisque tincidunt eleifend mauris sed volutpat. Donec tincidunt sollicitudin velit, sit amet malesuada lacus semper vestibulum. Sed laci"},
  {rating: 1, user_id: user4.id, business_id: 5, body: "Terrible! There was a fly in my soup. venenatis eget diam pellentesque, ultrices dictum nisi. Nullam quam lorem, lacinia ac justo nec, varius ullamcorper ligula."},
  {rating: 3, user_id: user4.id, business_id: 1, body: "I've had better. A lot better. but some worse. Vivamus eros elit, sagittis ultricies auctor et, ultrices sed leo. Vestibulum ligula leo, pharetra in ante nec, faucibus pretium sapien. Duis feugiat bibendum dui, in mattis nisl"},
  {rating: 5, user_id: user4.id, business_id: 2, body: "Mouth is drooling... Drooling! Nulla pharetra orci sit amet metus volutpat, ut hendrerit metus ornare. Curabitur aliquam vitae augue"},
  {rating: 3, user_id: user1.id, business_id: 3, body: "ontent of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."}
])

ps = Photo.all
PhotoDetail.create!([
  {helpful_id:1, photo_id: ps[0].id, store_front: false, user_id: user1.id},
  {helpful_id:2, photo_id: ps[1].id, store_front: true, user_id: user2.id},
  {helpful_id:3, photo_id: ps[2].id, store_front: false, user_id: user3.id},
  {helpful_id:2, photo_id: ps[3].id, store_front: false, user_id: user3.id},
  {helpful_id:1, photo_id: ps[4].id, store_front: false, user_id: user4.id},
  {helpful_id:2, photo_id: ps[5].id, store_front: true, user_id: user4.id},
  {helpful_id:3, photo_id: ps[6].id, store_front: true, user_id: user4.id},
  {helpful_id:2, photo_id: ps[7].id, store_front: false, user_id: user4.id}
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

Bookmark.create!([
  {business_id: 1, user_id: user1.id},
  {business_id: 2, user_id: user1.id},
  {business_id: 10, user_id: user1.id},
  {business_id: 4, user_id: user1.id},
  {business_id: 45, user_id: user1.id},
  {business_id: 1, user_id: user4.id},
  {business_id: 3, user_id: user4.id},
  {business_id: 12, user_id: user4.id},
  {business_id: 7, user_id: user4.id},
  {business_id: 35, user_id: user4.id}
])

Follow.create!([
  {fan_id: 2, leader_id: user1.id},
  {fan_id: 3, leader_id: user1.id},
  {fan_id: 4, leader_id: user1.id},
  {fan_id: 5, leader_id: user1.id},
  {fan_id: user1.id, leader_id: user2.id},
  {fan_id: user1.id, leader_id: 6},
  {fan_id: user1.id, leader_id: 10},
  {fan_id: user1.id, leader_id: 20},
  {fan_id: 12, leader_id: user4.id},
  {fan_id: 15, leader_id: user4.id},
  {fan_id: 3, leader_id: user4.id},
  {fan_id: 15, leader_id: user4.id},
  {fan_id: user4.id, leader_id: user2.id},
  {fan_id: user4.id, leader_id: 2},
  {fan_id: user4.id, leader_id: 7},
  {fan_id: user4.id, leader_id: 20}
])

Tip.create!([
  {body: "beware of rats", user_id: user1.id, business_id: 1},
  {body: "try the cheese", user_id: user1.id, business_id: 1},
  {body: "beware of cat", user_id: user1.id, business_id: 2},
  {body: "stay away from the bathrooms", user_id: user2.id, business_id: 3},
  {body: "tip well", user_id: user4.id, business_id: 4}
])

ReviewVote.create!([
  {review_id: 1, vote_id: 1, user_id: user2.id},
  {review_id: 1, vote_id: 2, user_id: User.limit(10).last.id},
  {review_id: 1, vote_id: 3, user_id: User.limit(32).last.id},
  {review_id: 1, vote_id: 1, user_id: User.limit(15).last.id},
  {review_id: 1, vote_id: 1, user_id: user4.id},
  {review_id: 202, vote_id: 1, user_id: user1.id},
  {review_id: 202, vote_id: 2, user_id: User.limit(20).last.id},
  {review_id: 202, vote_id: 3, user_id: user4.id},
  {review_id: 202, vote_id: 2, user_id: User.limit(60).last.id},
  {review_id: 202, vote_id: 3, user_id: user1.id},
  {review_id: 202, vote_id: 3, user_id: User.limit(10).last.id}
])

List.create!([
  {name: "favorite places", user_id: user1.id },
  {name: "exciting locations", user_id: user1.id },
  {name: "best places", user_id: user4.id },
  {name: "highly recommended", user_id: user4.id }
])

ListReview.create!([
  {list_id: 1, review_id: 1},
  {list_id: 2, review_id: 2},
  {list_id: 1, review_id: 3},
  {list_id: 2, review_id: 4},
  {list_id: 2, review_id: 5},
  {list_id: 3, review_id: 6},
  {list_id: 3, review_id: 7},
  {list_id: 4, review_id: 8},
  {list_id: 4, review_id: 18},
  {list_id: 4, review_id: 9}
])

ReviewCompliment.create!([
  {compliment_id: 1, review_id: 1, user_id: User.limit(5).last.id, body: "Amazing"},
  {compliment_id: 2, review_id: 1, user_id: User.limit(10).last.id, body: "You stink"},
  {compliment_id: 3, review_id: 2, user_id: User.limit(20).last.id, body: "thanks!"},
  {compliment_id: 4, review_id: 2, user_id: User.limit(20).last.id, body: "hilarious!"},
  {compliment_id: 5, review_id: 3, user_id: User.limit(20).last.id, body: "we should meetup!"},
  {compliment_id: 6, review_id: 4, user_id: User.limit(20).last.id, body: "that was crazy!"},
  {compliment_id: 7, review_id: 5, user_id: User.limit(20).last.id, body: "nice one."}
])


total_businesses = Business.count
50.times do |i|
  business_id = rand(1..total_businesses)

  start_index = rand(random_reviews.length-21)

  review = Review.create!(
                  rating: rand(5)+1,
                  user_id: User.limit(20).shuffle.last.id,
                  business_id: business_id,
                  body: random_reviews[start_index, rand(2..10)].join("\n"),
                  price_range: rand(5)
                )

  if rand(5) == 1
    ReviewCompliment.create!(  compliment_id: rand(1..11),
                              review_id: review.id,
                              user_id: rand(1..20),
                              body: Faker::Lorem.sentence
                            )
  end
  
  f_categories = FeatureCategory.all.shuffle[0,rand(3)]

  f_categories.each do |category|
    features = Feature.where(feature_category_id: category.id)
    feat_cnt = rand(features.length / 2)
    features = features.shuffle[0,feat_cnt]

    features.each do |feat|
      feat = features.shuffle!.pop

      val = if category.input_type == 1
        (rand(2) == 1 ? true : false)
      else
        true
      end

      BusinessFeature.create!(business_id: business_id, feature_id: feat.id, value: true, review_id: review.id)
    end

  end
end
