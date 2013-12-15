class ReviewVotesController < ApplicationController

  def create
    newVote = ReviewVote.new(params[:review_id])
    newVote.user_id = current_user.id

    newVote.save
    flash[:errors] = newVote.errors.full_messages

    if params[:back_url]
      redirect_to params[:back_url]
    else
      redirect_to root_url
    end

  end

  def destroy
    newVote = ReviewVote.find(params[:id])

    newVote.destroy
    flash[:errors] = newVote.errors.full_messages

    if params[:back_url]
      redirect_to params[:back_url]
    else
      redirect_to root_url
    end
  end

end
