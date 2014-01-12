class ReviewVotesController < ApplicationController

  def create
    params[:vote].merge!(user_id: current_user.id)
    newVote = ReviewVote.create(params[:vote])

    flash[:errors] = newVote.errors.full_messages

    redirect_to :back
  end

  def destroy
    newVote = ReviewVote.find(params[:id])

    newVote.destroy
    flash[:errors] = newVote.errors.full_messages

    redirect_to :back
  end

end
