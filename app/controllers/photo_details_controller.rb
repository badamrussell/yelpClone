class PhotoDetailsController < ApplicationController
  before_filter :require_current_user!, except: [:show]

  def update
    @photo_detail = current_user.photo_details.where(photo_id: params[:photo_id])[0]

    if @photo_detail.update_attributes(params[:photo_details])

    else
      flash[:errors] = @photo_detail.errors.full_messages
    end

    if request.xhr?
      render json: @photo_detail
    elsif params[:business_id]
      redirect_to business_photos_url(params[:business_id] , photo_id: params[:photo_id])
    elsif params[:user_id]
      redirect_to user_photos_url(params[:user_id] , photo_id: params[:photo_id])
    end
  end

  def create
    params[:photo_details].merge!( user_id: current_user.id )
    @photo_detail = PhotoDetail.creation(params[:photo_details])

    if @photo_detail.save

    else
      flash[:errors] = @photo_detail.errors.full_messages
    end

    if request.xhr?
      render json: @photo_detail
    elsif params[:business_id]
      redirect_to business_photos_url(params[:business_id] , photo_id: params[:photo_id])
    elsif params[:user_id]
      redirect_to user_photos_url(params[:user_id] , photo_id: params[:photo_id])
    end
  end

end
