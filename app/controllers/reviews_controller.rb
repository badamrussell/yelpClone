class ReviewsController < ApplicationController
  before_filter :require_current_user!, except: [:show]

  def new
    @review = Review.new
    @business = Business.find(params[:business_id])
  end

  def create
    flash[:errors] = []

    ActiveRecord::Base.transaction do
      newReview = current_user.reviews.create(params[:review])

      fail
      newFeatures = BusinessFeature.new


      newReview.save

      if params[:photo]
        params[:photo][:business_id] = newReview.business_id
        params[:photo][:review_id] = newReview.id

        newPhoto = current_user.photos.new(params[:photo])
        newPhoto.save
        flash[:errors] += newPhoto.errors.full_messages
      end

      flash[:errors] += newReview.errors.full_messages
    end

    if flash[:errors].empty?
      redirect_to business_url(params[:review][:business_id])
    else

      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end
end
