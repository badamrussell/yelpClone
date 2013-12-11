class ProfilesController < ApplicationController

  def show
    @profile = User.find(params[:id])
  end

  def edit
    @profile = User.find(params[:id])
  end

  def update
    @profile = User.find(params[:id])

    if @profile.update_attribute(params[:profile])
      redirect_to profile_url
    else
      flash[:errors] = @profile.errors.full_messages
      render :edit
    end
  end

end
