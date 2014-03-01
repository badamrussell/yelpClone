include ActionDispatch::TestProcess

FactoryGirl.define do

	# factory :guest do
	# 	first_name "Guest"
	# 	last_name "Gusterson"
	# 	email "guest@example.com"
	# 	password "123456"
	# end

	factory :country do
		name "USA"
	end

	factory :city do
		sequence(:name) { |n| "city_#{n}" }

		trait :and_down_to_neighborhoods do
			after(:create) do |city, evaluator|
				create(:area, :and_down_to_neighborhoods, city: city)
			end
		end
	end

	factory :area do
		sequence(:name) { |n| "area_#{n}" }
		city

		trait :and_down_to_neighborhoods do
			after(:create) do |area, evaluator|
				create(:neighborhood, area: area)
			end
		end
	end

	factory :neighborhood do
		sequence(:name) { |n| "neighborhood_#{n}" }
		area
	end

	factory :user do
		first_name "Bob"
		last_name "Bobber"
		email "bob@bobby.bob"
		password "123456"

		trait :profile_photo do
			profile_photo { fixture_file_upload("#{Rails.root.join}/app/assets/images/default_house.jpg", 'image/jpg') }
		end

		trait :guest do
			first_name "Guest"
			last_name "Gusterson"
			email "guest@example.com"
			password "123456"
		end
	end

	factory :feature_category do
		name "no_name_fc"
		input_type 2
	end

	factory :feature do
		name "non_name_feature"
		# category
	end

	factory :business do
		name "Terrible Restaurant"
		country_id 1


		trait :category_ids do |value|
			puts "FACTORY: #{value}"
			category_ids value
		end
		# NEED TO STUB OUT SOME CALLBACKS
		# Object.any_instance.stub(:foo).and_return(:return_value) ??????????????
		# after(:create) { |business| business.class.skip_callback(:create, :after, :geocode) }
		# after(:create) { |business| business.class.skip_callback(:create, :after, :reverse_geocode) }
		# callback(:after_stub, :after_validation) { puts "STUB AFTER VALIDATION" }
	 #  after(:stub, :create) { "BIZ AFTER STUB CREATE"  }
	 #  before(:create, :custom) { "BIZ BEFORE CREATE CUSTOM"  }

		# after(:create) { |business| puts "BIZ AFTER CREATE" }
		# trait :with_reviews do

		# end
	end


	# callback(:after_stub, :before_create) { do_something }
 #  after(:stub, :create) { do_something_else }
 #  before(:create, :custom) { do_a_third_thing }


	factory :review do
		rating 2
		body "awful"
		user
		business
	end


	factory :review_compliment do
		user
		body "great!"
	end

	factory :photo do
		user
		file { fixture_file_upload("#{Rails.root.join}/app/assets/images/default_user.jpg", 'image/jpg') }
	end

	factory :photo_detail do
		helpful
		photo_id 1
		store_front false
		user_id 1

		# after(:create) { |detail| puts "DETAIL AFTER CREATE" }
	end

	factory :business_feature do
		feature
		value true
	end

	factory :main_category do

		trait :with_categories do
			after(:create) do |main_category, evaluator|
				create_list(:category, 3, main_category: main_category)
			end
		end
	end

	factory :category do
		sequence(:name) { |n| "category_0#{n}" }
		main_category
	end

	factory :review_vote do
		vote_id 1
		user
		review
	end

	factory :helpful do

	end
	
	factory :vote do

		# trait :name do |value|
		# 	name value
		# end
	end

	factory :compliment do

	end

	

end