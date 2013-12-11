class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attribute(params[:profile])
      redirect_to profile_url
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

end
