require 'spec_helper'

feature "User writes a review" do
	before {
		setup_db
		
		loginGuest
	}

	scenario "from the business page", js: true do
		business = create(:business)

		# visit business_url(Business.first)
		search_and_go_to_business(business.name)
		# navigate_to_business
		click_button "Write a Review"

		fill_in "review_body", with: "an awesome example of testing"

		click_rating(3)
		
		click_button "Post Review"
		save_and_open_page

		# save_and_open_page
		expect(current_path).to eq(business_path(Business.first))
		expect(flash_notification).to have_content("Your 3 star review was added!")
	end

end