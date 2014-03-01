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

def setup_factories
  create(:user, :guest)
  create(:country, name: "USA")
  create(:city, :and_down_to_neighborhoods, name: "New York")
  create(:main_category, :with_categories, name: "Restaurants")

  fc_1 = create(:feature_category, name: "General Features", input_type: 1)
  fc_2 = create(:feature_category, name: "Alchol", input_type: 2)
  fc_3 = create(:feature_category, name: "Music", input_type: 1)

  create(:feature, name: "Accepts Credit Cards", feature_category_id: fc_1.id)
  create(:feature, name: "Delivery", feature_category_id: fc_1.id)
  create(:feature, name: "Outdoor Seating", feature_category_id: fc_1.id)

  create(:feature, name: "Full Bar", feature_category_id: fc_2.id)
  create(:feature, name: "Happy Hour", feature_category_id: fc_2.id)
  create(:feature, name: "Corkage", feature_category_id: fc_2.id)

  create(:feature, name: "DJ", feature_category_id: fc_3.id)
  create(:feature, name: "Karaoke", feature_category_id: fc_3.id)
  create(:feature, name: "Jukebox", feature_category_id: fc_3.id)

  # create(:price_range, name: "$", description: "$5-10")
  # create(:price_range, name: "$$", description: "$11-30")
  # create(:price_range, name: "$$$", description: "$31-60")
  # create(:price_range, name: "$$$$", description: "$61+")

  create(:helpful, name: "Very Helpful", value: 2)
  # create(:helpful, name: "Helpful", value: 1)
  # create(:helpful, name: "Not Helpful", value: -2)

  # create(:vote, name: "Useful")
  # create(:vote, name: "Funny")
  # create(:vote, name: "Cool")

  # create(:compliment, name: "Thank You")
  # create(:compliment, name: "Good Writer")
  # create(:compliment, name: "Great Photo")
  # create(:compliment, name: "Hot Stuff")
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
  category1 = Category.first.name
  visit("/businesses/new")

    # save_and_open_page

  fill_in "business_name", with: biz_name
  fill_in "business_address1", with: "770 Broadway Ave"
  fill_in "business_city", with: "New York City"
  fill_in "business_state", with: "NY"
  fill_in "business_zip_code", with: "10003"
  select category1, from: "business[category_ids][]"

  click_button "add-business"
end