class BookmarksController < ApplicationController
  before_filter :require_current_user!


	def create
		
		if Bookmark.where(user_id: current_user.id, business_id: params[:bookmark][:business_id]).empty?
			@bookmark = current_user.bookmarks.new(params[:bookmark])
			


			@bookmark.save

			flash[:errors] = @bookmark.errors.full_messages
			
			if request.xhr?
				render json: { id: @bookmark.id }
			else

			end

		else
			render json: {}
		end
	end

	def destroy
		@bookmark = Bookmark.find(params[:bookmrk_id])

		@bookmark.destroy

		flash[:errors] = @bookmark.errors.full_messages
		
		if request.xhr?
			render json: { business_id: @bookmark.business_id }
		else

		end
	end

	def show
		@user = User.find(params[:id])
	end

end
