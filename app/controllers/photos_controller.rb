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

  def show(owner, back_link, owner_hash)
    url_proc = Proc.new { |p| photo_details_url(p) }
    @photo_viewer = PhotoViewer.new(owner, owner_hash, params, url_proc, back_link)

    render :show
  end

  def biz_show
    owner = Business.find(params[:business_id])

    show(owner, business_url(owner.id), business_id: owner.id)
  end

  def user_show
    owner = User.find(params[:user_id])

    show(owner, user_url(owner.id), user_id: owner.id)
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
