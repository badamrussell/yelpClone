class ReviewsController < ApplicationController

  before_filter :require_current_user!, except: [:show]

  def new
    @review_full = ReviewFull.new_review(current_user, params)
  end

  def create
    @review_full = ReviewFull.create_review(current_user, params)

    @review_full.perform_transaction(nil)

    flash[:errors] = @review_full.errors

    if flash[:errors].empty?
      flash[:success] = ["Your #{@review_full.review.rating} star review was added!"]
      redirect_to business_url(@review_full.business.id)
    else
      render :new
    end
  end

  def edit
    @review_full = ReviewFull.update_review(current_user, params)
  end

  def update
    @review_full = ReviewFull.update_review(current_user, params, true)

    @review_full.perform_transaction(params[:review])

    flash[:errors] = @review_full.errors

    if flash[:errors].empty?
      redirect_to business_url(@review_full.review.business_id)
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
    action = ReviewVote.toggle(current_user, params[:id], params[:vote_id])
    vote = Vote.all_cached.select { |v| v.id == params[:vote_id].to_i }[0]
    
    toggle_vote_count = Vote.vote_counts[[params[:id], vote.id]]
    display_name = toggle_vote_count ? "#{vote.name} ( #{toggle_vote_count} )" : vote.name

    if request.xhr?
      render json: { id: vote.id, name: display_name, action: action }
    else
      redirect_to review_url(params[:id])
    end
  end

end
