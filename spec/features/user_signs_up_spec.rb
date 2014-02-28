require 'spec_helper'

feature "User signs up" do
	
	scenario "from top navigation link" do
		visit "/"

		top_menu.click_link("Sign Up")

		fill_in "user_first_name", with: "Charlie"
	  fill_in "user_last_name", with: "Guest"
	  fill_in "user_email", with: "abc@abc.com"
	  fill_in "user_password", with: "123456"

	  click_button "signup-user"

	  expect(current_path).to eq(user_path(User.last))
	end

	
end