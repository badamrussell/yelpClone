module VotesHelper

  def all_votes
    @all_votes ||= Vote.all
  end

  def vote_counts
    @vote_counts ||= Vote.joins(:review_votes).group(:review_id, "votes.id").count(:vote_id)
  end

  def user_votes
    @user_votes ||= current_user ? current_user.review_votes : []
  end

end
