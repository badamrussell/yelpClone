class ReviewsController < ApplicationController
  before_filter :require_current_user!, except: [:show]

  def new
    @review = Review.new
    @business = Business.find(params[:business_id])
    @business_features = current_user.completed_biz_features(params[:business_id])
  end

  def create
    flash[:errors] = []
    @review = current_user.reviews.create(params[:review])
    @business = Business.find(params[:review][:business_id])
    @business_features = current_user.completed_biz_features(@business.id)


    handle_transaction


    if flash[:errors].empty?
      redirect_to business_url(params[:review][:business_id])
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @business = Business.find(@review.business_id)
    @business_features = current_user.completed_biz_features(@review.business_id)
  end

  def update
    flash[:errors] = []
    @review = Review.find(params[:id])
    @business = Business.find(params[:review][:business_id])
    @business_features = current_user.completed_biz_features(@business.id)

    handle_transaction

    if flash[:errors].empty?
      redirect_to business_url(@business.id)
    else
      render :edit
    end
  end

  def destroy

  end

  def handle_transaction
    ActiveRecord::Base.transaction do
      existing_features = current_user.business_features.where(business_id: @business.id)
      #DOES NOT CONSIDER IF USER HAS ALREADY ADDED FEATURES BEFORE....
      existing_features.each do |f|
        if params[:feature_ids][f.feature_id].nil?
          f.destroy
        elsif params[:feature_ids][f.feature_id].blank?
          f.destroy
          params[:feature_ids].remove(f.feature_id)
        end
      end

      params[:feature_ids].each do |key,value|
        single_feature = current_user.business_features.where(business_id: @business.id, feature_id: key).first_or_initialize

        bool_value = (value == "1" ? true : false)

        single_feature.update_attribute(:value, bool_value)

        flash[:errors] += single_feature.errors.full_messages
      end

      if params[:photo] && !params[:photo][:img_url].blank?
        params[:photo][:business_id] = newReview.business_id
        params[:photo][:review_id] = newReview.id

        newPhoto = current_user.photos.new(params[:photo])
        newPhoto.save
        flash[:errors] += newPhoto.errors.full_messages
      end

      flash[:errors] += @review.errors.full_messages
    end
  end
end
