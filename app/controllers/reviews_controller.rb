class ReviewsController < ApplicationController

  include ReviewsHelper

  before_filter :require_current_user!, except: [:show]

  def new

    @review = Review.new
    @business = Business.find(params[:business_id])
    @business_features = {}
    @photo = Photo.new
    @review_features = makeFeatures(@business_features)

    puts(@review_features)
  end

  def create
    @review = current_user.reviews.new(params[:review])
    @business_features = format_features(params[:feature_ids])
    @review_features = makeFeatures(@business_features)

    flash[:errors] = @review.creation(nil, @business_features, params[:photo], current_user)

    if flash[:errors].empty?
      redirect_to business_url(params[:review][:business_id])
    else
      @business = Business.find(@review.business_id)
      @photo = Photo.new(params[:photo])

      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @business = Business.find(@review.business_id)
    @business_features = @review.completed_biz_features
    @photo = @review.photos.first || Photo.new
    @review_features = makeFeatures(@business_features)

    puts(@review_features)

  end

  def update
    @review = Review.find(params[:id])
    @business_features = format_features(params[:feature_ids])
    @review_features = makeFeatures(@business_features)

    flash[:errors] = @review.creation(params[:review], @business_features, params[:photo], current_user)

    if flash[:errors].empty?
      redirect_to business_url(@review.business_id)
    else
      @business = Business.find(@review[:business_id])
      @business_features = @review.business_features
      @photo = Photo.new(params[:photo])

      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])

    @review.destroy

    flash[:errors] = @review.errors.full_messages
    redirect_to business_url(@review.business_id)
  end

  def toggle_vote

    existingVote = current_user.review_votes.find_by_review_id_and_vote_id(params[:id], params[:vote_id])

    action = 1
    if existingVote.nil?
      existingVote = current_user.review_votes.create(vote_id: params[:vote_id], review_id: params[:id])
    else
      existingVote.destroy
      action = -1
    end

    vote = Vote.find(params[:vote_id])

    existing_vote = vote_counts[[params[:id], vote.id]]
    display_name = existing_vote ? "#{vote.name} ( #{existing_vote} )" : vote.name

    flash[:errors] = existingVote.errors.full_messages

    if request.xhr?
      render json: { id: vote.id, name: display_name, action: action }
    else
      redirect_to review_url(params[:id])
    end
  end

end
