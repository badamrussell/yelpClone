module NavigationHelpers

	def top_menu
		find(".search-nav")
	end

	def flash_notification
		find(".flash-notification")
	end

	def click_rating(value)
		within find(".star-rating-container") do
			find(".choice-#{value}").click
		end

		# page.execute_script("$('.choice-3').click()")
		# $('body').empty()
	end

	def navigate_to_business
		top_menu.find("#pg-search").click
	end

	def search_and_go_to_business(biz_name)
		within top_menu do
			fill_in "find", with: biz_name
			find("#pg-search").click
		end

		within find(".business-results") do
			# find(".business-info-container")
			click_link(biz_name)
		end

	end

end