require 'spec_helper'

feature "User can visit a business" do

	# SHOULD STUB GEOCODER...

	scenario 'create a new business', js: true do
		setup_factories
		loginGuest

		visit new_business_path

		category1 = Category.first.name
    fill_in "business_name", with: "Melrose Place"
	  fill_in "business_address1", with: "770 Broadway Ave"
	  fill_in "business_city", with: "New York City"
	  fill_in "business_state", with: "NY"
	  fill_in "business_zip_code", with: "10003"
	  select category1, from: "business[category_ids][]"

	  click_button "add-business"

	  expect(current_path).to eq(business_path(Business.last))
		expect(flash_notification).to have_content("Melrose Place was added!")
	end

	feature "and edit it", js: true do
		
		scenario 'change name of business' do
			setup_factories
			loginGuest
			
			makeBusiness("Melrose Place")
			page.find(".edit-biz").click

			fill_in "business_name", with: "Roadhouse"

			click_button "add-business"

			expect(current_path).to eq(business_path(Business.last))
			expect(flash_notification).to have_content("Roadhouse was updated!")
		end

		scenario 'change categories' do
			setup_factories
			loginGuest

			category1 = Category.first.name
			category2 = Category.last.name

			makeBusiness("Melrose Place")
			page.find(".edit-biz").click

			click_button "Add another category"

			categories = page.all(".category-selects")
			within categories[0] do
				select category1, from: "business[category_ids][]"
			end
			within categories[1] do
				select category2, from: "business[category_ids][]"
			end
			
			click_button "Update"
			
			new_categories = page.all(".category-container a")
			expect(current_path).to eq(business_path(Business.last))
			expect(flash_notification).to have_content("Melrose Place was updated!")

			find(".category-container").should have_content(category1)
			find(".category-container").should have_content(category2)
		end

	end

	scenario 'create a new business with an initial review', js: true do
		setup_factories
		loginGuest
		category1 = Category.first.name

		visit new_business_path

		fill_in "business_name", with: "Melrose Place"
	  fill_in "business_address1", with: "770 Broadway Ave"
	  fill_in "business_city", with: "New York City"
	  fill_in "business_state", with: "NY"
	  fill_in "business_zip_code", with: "10003"
	  select category1, from: "business[category_ids][]"

	  fill_in "review_body", with: "test review content."

	  within find(".review-area") do
	  	fill_in "review_body", with: "an awesome example of testing"
			click_rating(3)
	  end
	  
	  click_button "add-business"

	  expect(current_path).to eq(business_path(Business.last))
		expect(flash_notification).to have_content("Melrose Place was added!")
	end

end
