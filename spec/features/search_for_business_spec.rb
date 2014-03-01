require 'spec_helper'

feature "User searches for business" do
	
	scenario "using postgres" do
		setup_factories
		business = create(:business, name: "Melrose Place")

		loginGuest

		search_and_go_to_business("Melrose Place", "pg")

		expect(current_path).to eq(business_path(business))
	end

	pending "using elasticsearch" do
		setup_factories
		business = create(:business, name: "Melrose Place")

		loginGuest

		search_and_go_to_business("Melrose Place", "es")

		expect(current_path).to eq(business_path(business))
	end

	def search_and_go_to_business(biz_name, search_type)

		within top_menu do
			fill_in "find", with: biz_name

			if search_type == "pg"
				find("#pg-search").click
			else
				find("#es-search").click
			end
		end

		within find(".business-results") do
			# find(".business-info-container")
			click_link(biz_name)
		end

	end
	
end