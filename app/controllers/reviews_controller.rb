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
      newReview.save

      #DOES NOT CONSIDER IF USER HAS ALREADY ADDED FEATURES BEFORE....
      #b_features = current_user.business_features.where(business_id: newReview.business_id)
      params[:feature_ids].each do |key,value|
        unless value.blank?
          bool_value = (value == "1" ? true : false)

          newFeat = current_user.business_features.create( feature_id: key, business_id: newReview.business_id, value: bool_value )
          puts value
          puts bool_value
          puts newFeat
          puts "---------------"
          flash[:errors] += newFeat.errors.full_messages
        else
          #remove it...
        end
      end



      if params[:photo] && !params[:photo][:img_url].blank?
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
