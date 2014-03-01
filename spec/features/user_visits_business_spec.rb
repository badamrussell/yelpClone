require 'spec_helper'

feature "User can visit a business" do

	before {
		setup_db

		loginGuest
	}


	# SHOULD STUB GEOCODER...

	scenario 'create a new business', js: true do
		puts "Feature: #{Feature.count}"
		visit new_business_path

    fill_in "business_name", with: "Melrose Place"
	  fill_in "business_address1", with: "770 Broadway Ave"
	  fill_in "business_city", with: "New York City"
	  fill_in "business_state", with: "NY"
	  fill_in "business_zip_code", with: "10003"
	  select "Afghan", from: "business[category_ids][]"

	  click_button "add-business"

	  expect(current_path).to eq(business_path(Business.last))
		expect(flash_notification).to have_content("Melrose Place was added!")
	end

	feature "and edit it", js: true do
		before do
			# Business.create(name: "Melrose Place", address1: "770 Broadway Ave", city: "New York City", state: "NY", zip_code: "10003", category_ids: [Category.first.id])
			makeBusiness("Melrose Place")
			# search_and_go_to_business("Melrose Place")
			# puts "Business: #{Business.count}"
			# visit business_path(Business.first)
			page.find(".edit-biz").click
		end


		scenario 'change name of business' do
			fill_in "business_name", with: "Roadhouse"

			click_button "add-business"

			expect(current_path).to eq(business_path(Business.last))
			expect(flash_notification).to have_content("Roadhouse was updated!")
		end

		scenario 'change categories' do
			click_button "Add another category"

			categories = page.all(".category-selects")
			within categories[0] do
				select "American", from: "business[category_ids][]"
			end
			within categories[1] do
				select "Italian", from: "business[category_ids][]"
			end
			
			click_button "Update"
			
			new_categories = page.all(".category-container a")
			expect(current_path).to eq(business_path(Business.last))
			expect(flash_notification).to have_content("Melrose Place was updated!")

			find(".category-container").should have_content("American")
			find(".category-container").should have_content("Italian")
		end

	end

	scenario 'create a new business with an initial review', js: true do
		visit new_business_path

		fill_in "business_name", with: "Melrose Place"
	  fill_in "business_address1", with: "770 Broadway Ave"
	  fill_in "business_city", with: "New York City"
	  fill_in "business_state", with: "NY"
	  fill_in "business_zip_code", with: "10003"
	  select "Afghan", from: "business[category_ids][]"

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
