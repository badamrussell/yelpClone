require 'spec_helper'

feature "User compliments a review" do
	scenario "from home page", js: true do
		setup_factories
		loginGuest

		review = other_user_review
		compliment_name = Compliment.first(2)[1].name

		visit "/"

		within find(".quick-compliment") do
			fill_in "compliment[body]", with: "useless comment"
			select_compliment_from_dropdown(compliment_name)

			click_button "Send"
		end

		visit user_path(review.user)

		find("#recent-compliments").should have_content(compliment_name)
		find("#recent-compliments").should have_content("useless comment")
	end

	def select_compliment_from_dropdown(name)
		within find(".compliment-controls") do
			find(".drop-menu").click
			choose name
		end
	end
end