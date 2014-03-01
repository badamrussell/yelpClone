require 'spec_helper'

feature "User votes on review" do
	feature "from home page" do

		scenario "add one vote", js: true do
			setup_factories
			loginGuest

			review = other_user_review
			vote_name = Vote.first.name

			visit "/"

			within find(".review-upvote-container") do
				buttons = all("button")
				buttons[0].click

				buttons[0].should have_content(1)
			end
		end

		scenario "toggle vote off", js: true do
			setup_factories
			loginGuest

			review = other_user_review
			vote_name = Vote.first.name

			visit "/"

			within find(".review-upvote-container") do
				buttons = all("button")
				buttons[0].click
				buttons[0].click
				buttons[0].should_not have_content(1)
			end
		end

	end

end