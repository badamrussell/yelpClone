class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @business = Business.find(params[:business_id])
  end

  def create
    flash[:errors] = []

    ActiveRecord::Base.transaction do
      newReview = current_user.reviews.create(params[:review])

      newDetails = newReview.details.create(params[:restaurant_details])

      flash[:errors] += newReview.errors.full_messages
      flash[:errors] += newDetails.errors.full_messages
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
