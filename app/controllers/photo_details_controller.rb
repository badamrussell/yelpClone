class PhotoDetailsController < ApplicationController

  def edit
    fail
  end

  def update
    @photo_detail = current_user.photo_details.where(photo_id: params[:photo_id])[0]

    if @photo_detail.update_attributes(params[:photo_details])

    else
      flash[:errors] = @photo_detail.errors.full_messages
    end

    if params[:business_id]
      redirect_to business_photos_url(params[:business_id] , photo_id: params[:photo_id])
    elsif params[:user_id]
      redirect_to business_photos_url(params[:user_id] , photo_id: params[:photo_id])
    end
  end

  def create
    @photo_detail = current_user.photo_details.new(params[:photo_details])
    @photo_detail.photo_id = params[:photo_id]
    if @photo_detail.save

    else
      flash[:errors] = @photo_detail.errors.full_messages
    end

    if params[:business_id]
      redirect_to business_photos_url(params[:business_id] , photo_id: params[:photo_id])
    elsif params[:user_id]
      redirect_to business_photos_url(params[:user_id] , photo_id: params[:photo_id])
    end
  end

end
