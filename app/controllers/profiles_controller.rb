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



    if @profile.update_attributes(params[:profile])
      current_user.set_avatar(params[:user][:img_url])

      redirect_to profile_url
    else
      flash[:errors] = @profile.errors.full_messages
      render :edit
    end
  end

end
