require 'spec_helper'

feature "User can visit a business" do

	before {
		loginGuest
	}

	# SHOULD STUB GEOCODER...

	scenario 'create a new business' do
		makeBusiness("Melrose Place")

		find(".page-title").should have_content("Melrose Place")
		# save_and_open_page
	end

	feature "and edit it" do
		before do
			makeBusiness("Melrose Place")
			page.find(".edit-biz").click
		end

		scenario 'change name of business' do
			find(".page-title").should have_content("Edit Business")

			fill_in "business_name", with: "Roadhouse"

			click_button "add-business"
			find(".page-title").should have_content("Roadhouse")
		end

		pending 'change categories' do

		end

	end

	pending 'create a new business with an initial review' do
		# HOW TO ADD RATING TO REVIEW?

		visit("/businesses/new")

    fill_in "business_name", with: "Melrose Place"
	  fill_in "business_address1", with: "770 Broadway Ave"
	  fill_in "business_city", with: "New York City"
	  fill_in "business_state", with: "NY"
	  fill_in "business_zip_code", with: "10003"
	  select "Afghan", from: "business[category_ids][]"

	  fill_in "review_body", with: "test review content."
	  # click_on(".choice-2")
	  # fill_in "review_rating", with: "2"
		# page.find(".choice-2").click
	  # page.execute_script("$('body').empty()")
		page.execute_script('$("#review_rating").attr("value", $target.data("id"))')

	  click_button "add-business"

	  # save_and_open_page
	  find(".page-title").should have_content("Melrose Place")
	  find(".basic-review-container").should have_content("test review content.")
	  find(".basic-review-container").should have_css(".star-large-20")
	end

end
