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

	

end