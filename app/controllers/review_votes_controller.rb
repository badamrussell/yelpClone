class ReviewVotesController < ApplicationController

  def create
    newVote = ReviewVote.new(params[:vote])
    newVote.user_id = current_user.id

    newVote.save
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
