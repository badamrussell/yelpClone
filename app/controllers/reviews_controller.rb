class ReviewsController < ApplicationController

  before_filter :require_current_user!, except: [:show]

  def new
    @review = Review.new
    @business = Business.find(params[:business_id])
    @business_features = []
    @photo = Photo.new
  end

  def create
    @review = current_user.reviews.new(params[:review])
    @business = Business.find(@review.business_id)


    # puts params
    # puts "---------------------------------"
    # handle_transaction

    flash[:errors] = @review.handle_update(nil, params[:feature_ids], params[:photo], current_user)

    if flash[:errors].empty?
      redirect_to business_url(params[:review][:business_id])
    else
      @business_features = {}

      params[:feature_ids].each do |k,v|
        if v == "1"
          @business_features[k] = true
        elsif k.to_i > 1
          @business_features[v] = true
        else
          @business_features[k] = false
        end
      end
      puts @business_features
      puts "----------------------------"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @business = Business.find(@review.business_id)
    @business_features = @review.completed_biz_features

    @photo = @review.photos.first || Photo.new
    puts @business_features
    puts "---------------------------------"
  end

  def update
    @review = Review.find(params[:id])
    @business = Business.find(@review[:business_id])
    @business_features = @review.business_features

    # puts params[:feature_ids]
    # puts "------------UPDATE---------------------"


    flash[:errors] = @review.handle_update(params[:review], params[:feature_ids], params[:photo], current_user)
    # @review.update_attributes(params[:review])
    # handle_transaction

    if flash[:errors].empty?
      redirect_to business_url(@business.id)
    else
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
    # vote_count = Review.find(params[:id]).vote_count[vote.id]
    existing_vote = vote_counts[[params[:id], vote.id]]
    display_name = if existing_vote
        "#{vote.name} ( #{existing_vote} )"
      else
        vote.name
      end

    flash[:errors] = existingVote.errors.full_messages

    if request.xhr?
      render json: { id: vote.id, name: display_name, action: action }
    else
      redirect_to review_url(params[:id])
    end
  end

end
