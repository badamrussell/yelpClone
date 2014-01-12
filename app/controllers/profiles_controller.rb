class ProfilesController < ApplicationController
  before_filter :require_current_user!

  def show
    @profile = UserBio.find_by_user_id(current_user.id)
  end

  def edit
    @profile = UserBio.find_by_user_id(current_user.id)
  end

  def update
    @profile = UserBio.find_by_user_id(current_user.id)
    flash[:errors] = @profile.creation(current_user, params[:profile], params[:user])

    if flash[:errors].empty?
      redirect_to profile_url
    else
      render :edit
    end
  end

end
