module VotesHelper

  def all_votes
    Vote.all_cached
  end

  def vote_counts
  	Vote.vote_counts
  end

  def user_votes
    @user_votes ||= current_user ? current_user.review_votes : []
  end

end
