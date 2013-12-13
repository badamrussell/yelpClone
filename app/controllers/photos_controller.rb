class PhotosController < ApplicationController

  def new
    @photo = Photo.new
    @business = params[:business_id] ? Business.find(params[:business_id]) : nil
  end

  def create
    @photo = current_user.photos.new(params[:photo])

    if @photo.save
      if @photo.business_id
        redirect_to business_url(@photo.business_id)
      else
        redirect_to user_url(current_user.id)
      end
    else
      @business = @photo.business_id ? Business.find(@photo.business_id) : nil
      flash[:errors] = @photo.errors.full_messages
      render :new
    end
  end

  def show
    @select_id = params[:photo_id].to_i
    @photo = Photo.new
    @business = params[:business_id] ? Business.find(params[:business_id]) : nil
    @photos = @business.photos
  end

  def destroy

  end

  def edit
    @photo = Photos.find(params[:id])
  end

  def update
    @photo = Photos.find(params[:id])
  end
end
