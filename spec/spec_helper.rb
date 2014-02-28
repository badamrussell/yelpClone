# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
# Capybara.javascript_driver = :webkit

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # load "#{Rails.root}/db/test_seeds.rb"
  config.include FactoryGirl::Syntax::Methods
  
  config.include NavigationHelpers, type: :feature

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end

end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

def setup_db
  User.create!( email: "guest@example.com", password: "123456", first_name: "Guest", last_name: "Gusterson" )
  Country.create(name: "USA")
  main_category1 = MainCategory.create!(name: "Restaurants")
  city1 = City.create!(name: "New York")


  area1 = Area.create!(name: "Manhattan", city_id: city1.id)
  Neighborhood.create!(name: "Harlem", area_id: area1.id)
  Category.create(main_category_id: main_category1.id, name: "Afghan")
  Category.create(main_category_id: main_category1.id, name: "American")
  Category.create(main_category_id: main_category1.id, name: "Italian")

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
  
  fc_base = FeatureCategory.first.id
  Feature.create!([
  # { name: "Offering a Deal", feature_category_id: 1 },  #1
  # { name: "Open At:", feature_category_id: 1 },
  # { name: "Open Now:", feature_category_id: 1 },
  { name: "Accepts Credit Cards", feature_category_id: fc_base },
  { name: "Delivery", feature_category_id: fc_base },
  { name: "Outdoor Seating", feature_category_id: fc_base },
  { name: "Good for Groups", feature_category_id: fc_base },
  { name: "Good for Kids", feature_category_id: fc_base },
  { name: "Take-out", feature_category_id: fc_base },
  { name: "Wheelchair Accessible", feature_category_id: fc_base },
  { name: "Has TV", feature_category_id: fc_base },
  { name: "Liked by 20-somethings:", feature_category_id: fc_base },

  { name: "Caters", feature_category_id: fc_base },
  { name: "Dogs Allowed", feature_category_id: fc_base },
  { name: "Open 24 Hours", feature_category_id: fc_base },
  { name: "Order at Counter", feature_category_id: fc_base },
  { name: "Takes Reservations", feature_category_id: fc_base },
  { name: "Waiter Service", feature_category_id: fc_base },

  { name: "Full Bar", feature_category_id: fc_base + 1 },
  { name: "Happy Hour", feature_category_id: fc_base + 1 },
  { name: "Beer & Wine Only", feature_category_id: fc_base + 1 },
  { name: "BYOB", feature_category_id: fc_base + 1 },
  { name: "Corkage", feature_category_id: fc_base + 1 }, #20

  { name: "Breakfast", feature_category_id: fc_base + 2 },
  { name: "Brunch", feature_category_id: fc_base + 2 },
  { name: "Lunch", feature_category_id: fc_base + 2 },
  { name: "Dinner", feature_category_id: fc_base + 2 },
  { name: "Dessert", feature_category_id: fc_base + 2 },
  { name: "Late Night", feature_category_id: fc_base + 2 },

  { name: "DJ", feature_category_id: fc_base + 3 },
  { name: "Jukebox", feature_category_id: fc_base + 3 },
  { name: "Karaoke", feature_category_id: fc_base + 3 },
  { name: "Live", feature_category_id: fc_base + 3 }, #30

  { name: "Street", feature_category_id: fc_base + 4 },
  { name: "Garage", feature_category_id: fc_base + 4 },
  { name: "Valet", feature_category_id: fc_base + 4 },
  { name: "Private-Lot", feature_category_id: fc_base + 4 },
  { name: "Validated", feature_category_id: fc_base + 4 },

  { name: "Free", feature_category_id: fc_base + 5 },
  { name: "Paid", feature_category_id: fc_base + 5 },

  { name: "Outdoor Area / Patio Only", feature_category_id: fc_base + 6 },

  { name: "Divey", feature_category_id: fc_base + 7 },
  { name: "Hipster", feature_category_id: fc_base + 7 }, #40
  { name: "Casual", feature_category_id: fc_base + 7 },
  { name: "Touristy", feature_category_id: fc_base + 7 },
  { name: "Trendy", feature_category_id: fc_base + 7 },
  { name: "Intimate", feature_category_id: fc_base + 7 },
  { name: "Romantic", feature_category_id: fc_base + 7 },
  { name: "Classy", feature_category_id: fc_base + 7 },
  { name: "Upscale", feature_category_id: fc_base + 7 },

  { name: "Casual", feature_category_id: fc_base + 8 },
  { name: "Dressy", feature_category_id: fc_base + 8 },
  { name: "Formal (Jacket Required)", feature_category_id: fc_base + 8 },

  { name: "Quiet", feature_category_id: fc_base + 9 },
  { name: "Average", feature_category_id: fc_base + 9 },
  { name: "Loud", feature_category_id: fc_base + 9 },
  { name: "Very Loud", feature_category_id: fc_base + 9 }
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
end


def signupUser(username)
  visit "/users/new"

  fill_in "user_first_name", with: "Charlie"
  fill_in "user_last_name", with: "Guest"
  fill_in "user_email", with: username
  fill_in "user_password", with: "123456"

  click_button "signup-user"
end

def loginGuest
  visit "/"

  click_button "login-guest"
end

def makeBusiness(biz_name)
  visit("/businesses/new")

    # save_and_open_page

  fill_in "business_name", with: biz_name
  fill_in "business_address1", with: "770 Broadway Ave"
  fill_in "business_city", with: "New York City"
  fill_in "business_state", with: "NY"
  fill_in "business_zip_code", with: "10003"
  select "Afghan", from: "business[category_ids][]"

  click_button "add-business"
end