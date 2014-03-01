require 'spec_helper'

feature "User writes a review" do
	
	scenario "from the business page", js: true do
		setup_factories
		loginGuest
		
		business = create(:business)

		visit business_path(business)
		click_button "Write a Review"

		fill_in "review_body", with: "an awesome example of testing"

		click_rating(3)
		
		click_button "Post Review"

		expect(current_path).to eq(business_path(business))
		expect(flash_notification).to have_content("Your 3 star review was added!")
	end

end