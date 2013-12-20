class ReviewsController < ApplicationController
  before_filter :require_current_user!, except: [:show]

  def new
    @review = Review.new
    @business = Business.find(params[:business_id])
    @business_features = []
  end

  def create
    flash[:errors] = []
    @review = current_user.reviews.new(params[:review])
    @business = Business.find(@review.business_id)


    puts params
    puts "---------------------------------"
    handle_transaction

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

    puts @business_features
    puts "---------------------------------"
  end

  def update
    flash[:errors] = []
    @review = Review.find(params[:id])
    @business = Business.find(@review[:business_id])
    @business_features = @review.business_features

    puts params[:feature_ids]
    puts "------------UPDATE---------------------"

    @review.update_attributes(params[:review])
    handle_transaction

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

  def handle_transaction
    @review.transaction do
      @review.save
      existing_features = @review.business_features.where(business_id: @business.id)



      existing_features.each do |f|
        if params[:feature_ids][f.feature_id].nil?
          f.destroy
        elsif params[:feature_ids][f.feature_id].blank?
          f.destroy
          params[:feature_ids].remove(f.feature_id)
        end
      end

      if params[:feature_ids]
        params[:feature_ids].each do |key,value|
          key_id = key
          bool_value = if value == "1"
                true
              elsif key.to_i == 0
                key_id = value.to_i
                true
              else
                false
              end

          single_feature = @review.business_features.where(feature_id: key_id, business_id: @review.business_id).first_or_initialize
          single_feature.update_attribute(:value, bool_value)
          #single_feature.review_id = 1
          # if params[:action] == "post"
          #     @review.business_features.new(business_id: @business.id, feature_id: key_id, value: bool_value)
          #   else
          #
          #     @review.business_features.new(business_id: @business.id, feature_id: key_id, value: bool_value)
          #   end
          # puts ">  business_id: #{@business.id}, feature_id: #{key_id}, value: #{bool_value}, valid? #{single_feature.valid?}, #{single_feature.review_id}"
          #single_feature = @review.business_features.where(business_id: @business.id, feature_id: key_id).first_or_initialize
          #single_feature.update_attribute(:value, bool_value)

          flash[:errors] += single_feature.errors.full_messages
        end
      end
      #save photo
      if params[:photo] && !params[:photo][:file].blank?
        params[:photo][:business_id] = @review.business_id
        params[:photo][:review_id] = @review.id

        newPhoto = current_user.photos.new(params[:photo])

        newPhoto.save
        flash[:errors] += newPhoto.errors.full_messages
      end

      @review.save
      flash[:errors] += @review.errors.full_messages
    end
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
    vote_count = Review.find(params[:id]).vote_count[vote.id]
    display_name = if vote_count
        "#{vote.name} ( #{vote_count} )"
      else
        vote.name
      end

    flash[:errors] = existingVote.errors.full_messages

    if request.xhr?
      render json: { id: vote.id, name: display_name, actino: action }
    else
      redirect_to review_url(params[:id])
    end
  end

end
