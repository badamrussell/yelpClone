class PhotosController < ApplicationController
  before_filter :require_current_user!, except: [:show]

  def new
    @photo = Photo.new
    @business = params[:business_id] ? Business.find(params[:business_id]) : nil
  end

  def create
    @photo = current_user.photos.new(params[:photo])

    if @photo.save
      if params[:business_id]
        business = Business.find(params[:business_id])
        business.update_attribute(:store_front_id, @photo.id) if business.missing_store_front?
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
    @owner = params[:business_id] ? Business.find(params[:business_id]) : nil
    @photos = @owner.photos
    @select_id = params[:photo_id] ? @photos.index(Photo.find(params[:photo_id])) : 0
    @photo = @photos[@select_id] || Photo.new
    @url = photo_details_url(@photo.id, business_id: @owner.id) if @photos.any?
    @back_link = business_url(@owner.id)

    @photos = Kaminari.paginate_array(@photos).page(params[:page]).per(1)
    render :show
  end

  def user_show
    @owner = User.find(params[:user_id])
    @photos = @owner.photos
    @select_id = params[:photo_id] ? @photos.index(Photo.find(params[:photo_id])) : 0
    @photo = @photos[@select_id] || Photo.new
    @url = photo_details_url(@photo.id, user_id: @owner.id) if @photos.any?
    @back_link = user_url(@owner.id)
    @photos = Kaminari.paginate_array(@photos).page(params[:page]).per(1)
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
