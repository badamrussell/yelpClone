class PhotosController < ApplicationController
  before_filter :require_current_user!, except: [:show, :biz_show, :user_show]

  def new
    @photo = Photo.new
    @business = params[:business_id] ? Business.find(params[:business_id]) : nil
  end

  def create
    @photo = current_user.photos.new(params[:photo])

    if @photo.save
      if params[:business_id]
        # business = Business.find(params[:business_id])
        # business.update_attribute(:avatar_id, @photo.id) if business.missing_store_front?
        redirect_to business_url(params[:business_id])
      else
        redirect_to user_url(current_user.id)
      end
    else
      @business = @photo.business_id ? Business.find(@photo.business_id) : nil
      flash[:errors] = @photo.errors.full_messages
      render :new
    end
  end

  def biz_show
    @owner = Business.find(params[:business_id])
    @photos = @owner.photos.order(:id)

    page_index = params[:page] || ( params[:photo_id] ? @photos.pluck(:id).index(params[:photo_id].to_i)+1 : 1 )

    @photos = Kaminari.paginate_array(@photos).page(page_index).per(1)
    @photo = @photos[0]

    @url = photo_details_url(@photo.id, business_id: @owner.id) if @photos.any?
    @back_link = business_url(@owner.id)

    render :show
  end

  def user_show
    @owner = User.find(params[:user_id])
    @photos = @owner.photos.order(:id)

    page_index = params[:page] || ( params[:photo_id] ? @photos.pluck(:id).index(params[:photo_id].to_i)+1 : 1 )

    @photos = Kaminari.paginate_array(@photos).page(page_index).per(1)
    @photo = @photos[0]

    @url = photo_details_url(@photo.id, user_id: @owner.id) if @photos.any?
    @back_link = user_url(@owner.id)

    render :show
  end

  def destroy

  end

  def edit
    @photo = Photos.find(params[:id])
    fail
  end

  def update
    @photo = Photos.find(params[:id])
    fail
  end
end
