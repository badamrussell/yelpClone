class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.verify_credentials(params[:user][:email], params[:user][:password])

    if @user
      sign_in(@user)

      flash[:success] = ["Welcome back to Yelp Clone!"]
      redirect_to user_url(@user)
    else
      flash[:errors] = ["invalid credentials"]
      render :new
    end
  end

  def destroy
    sign_out

    flash[:success] = ["Thanks for using Yelp Clone! See you again!"]
    redirect_to new_session_url

  end

end
