class PhotoViewer
  attr_reader :owner, :owner_hash

	def initialize(owner, owner_hash, params, url_proc, back_url)
		@owner = owner
		@owner_hash = owner_hash
		@photos = owner.photos.order(:id)
		@params = params
		@url_proc = url_proc
		@back_url = back_url
	end

	def paginated_photos
		@page_photos ||= Kaminari.paginate_array(@photos).page(page_index).per(1)
	end

	def current_page
		paginated_photos.current_page
	end

	def total_pages
		paginated_photos.total_pages
	end

	def page_index
		@params[:page] || ( @params[:photo_id] ? @photos.pluck(:id).index(@params[:photo_id].to_i)+1 : 1 )
	end

	def photo
		@page_photos[0]
	end

	def url
		@url_proc.call(photo.id, owner_hash) if @photos
	end

	def back_link
		@back_url
	end

	def details_for(user)
		photo.user_details(user.id).first
	end
end
