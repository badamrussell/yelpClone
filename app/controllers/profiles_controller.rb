class ProfilesController < ApplicationController
  before_filter :require_current_user!

  def show
    @profile = UserBio.find_by_user_id(current_user.id)
  end

  def edit
    @profile = UserBio.find_by_user_id(current_user.id)
  end

  def update
    flash[:errors] = []

    ActiveRecord::Base.transaction do
      @profile = UserBio.find_by_user_id(current_user.id)

      @profile.update_attributes(params[:profile])
      current_user.update_attributes(params[:user])

      flash[:errors] += @profile.errors.full_messages
      flash[:errors] += current_user.errors.full_messages
    end


    if flash[:errors].empty?
      redirect_to profile_url
    else
      render :edit
    end
  end

end
