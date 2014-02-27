include ActionDispatch::TestProcess

FactoryGirl.define do

	factory :user do
		first_name "Bob"
		last_name "Bobber"
		email "bob@bobby.bob"
		password "123456"

		trait :profile_photo do
			profile_photo { fixture_file_upload("#{Rails.root.join}/app/assets/images/default_house.jpg", 'image/jpg') }
		end
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
		user_id 1

		trait :rating do |value|
			rating value
		end
		
		trait :body do |value|
			body value
		end
		trait :business_id do |value|
			business_id value
		end

		trait :price_range do |value|
			price_range value
		end

		trait :user_id do |value|
			user_id value
		end
	end


	factory :review_compliment do
		user_id 1
		body "great!"

		trait :compliment_id do |value|
			compliment_id value
		end
		trait :review_id do |value|
			review_id value
		end
	end

	factory :photo do
		user_id 1
		file { fixture_file_upload("#{Rails.root.join}/app/assets/images/default_user.jpg", 'image/jpg') }


		trait :business_id do |value|
			business_id value
		end

		trait :heplful_sum do |value|
			helpful_sum value
		end

		trait :store_front_count do |value|
			store_front_count value
		end

		trait :user_id do |value|
			user_id value
		end
		# after(:create) { |photo| puts "PHOTO AFTER CREATE" }
	end

	factory :photo_detail do
		helpful_id 1
		photo_id 1
		store_front false
		user_id 1

		trait :photo_id do |value|
			photo_id value
		end

		trait :store_front do |value|
			store_front value
		end

		# after(:create) { |detail| puts "DETAIL AFTER CREATE" }
	end

	factory :business_feature do
		feature_id 1
		value true 

		trait :business_id do |value|
			business_id value
		end

		trait :review_id do |value|
			review_id value
		end

		trait :feature_id do |value|
			feature_id value
		end
	end

	factory :category do
		main_category_id 1

		trait :name do |value|
			name value
		end
	end

	factory :review_vote do
		vote_id 1
		user_id 1

		trait :review_id do |value|
			review_id value
		end

		trait :user_id do |value|
			user_id value
		end

		trait :vote_id do |value|
			vote_id value
		end
	end


	factory :vote do

		trait :name do |value|
			name value
		end
	end

	# factory :compliment do

	# end

	

end