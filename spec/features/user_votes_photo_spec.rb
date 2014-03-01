require 'spec_helper'

feature "User votes on photo" do

	scenario "from viewing individual photo", js: true do
		setup_factories
		loginGuest
		photo = add_photo_from_other_user
		helpful_name = Helpful.first.name

		visit user_photos_path(photo.user_id)

		within_fieldset("photo-detail-choices") do
			choices = all("input")
			choices[0].click
		end
		# check "Mark as storefront photo"

		visit "/"
		visit user_photos_path(photo.user_id)

		within_fieldset("photo-detail-choices") do
			choices = all("input")
			choices[0].should be_selected
		end

	end

	scenario "marks photo as storefront", js: true do
		setup_factories
		
		photo = add_photo_from_other_user

		loginGuest

		visit user_photos_path(photo.user_id)

		check "Mark as storefront photo"

		visit "/"
		visit user_photos_path(photo.user_id)

		# save_and_open_page
		find('#photo_details_store_front').should be_checked

	end

	def add_photo_from_other_user
		user2 = create(:user, email: "c@d.com")
		business = create(:business)
  	create(:photo, business: business, store_front_count: 0, user: user2)
	end
end