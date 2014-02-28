require 'spec_helper'

feature "Existing User signs in" do
	before {
		setup_db
		User.create!( email: "man@example.com", password: "654321", first_name: "Manfred", last_name: "Manly" )
	}

	scenario "from top navigation link" do
		visit "/"

		top_menu.click_link("Log In")

	  fill_in "user_email", with: "man@example.com"
	  fill_in "user_password", with: "654321"
	  click_button "Log in"

	  expect(current_path).to eq(user_path(User.find_by_email("man@example.com")))
	end
	
	scenario "as guest" do
		visit "/"

		top_menu.click_link("Log In")
	  click_button "Log in as Guest"

	  expect(current_path).to eq(user_path(User.find_by_email("guest@example.com")))
	end

end