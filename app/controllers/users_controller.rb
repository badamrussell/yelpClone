class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    if @user

    else
      flash[:errors] = @user.errors.messages
      # render @user
      redirect_to users_url
    end
  end

  def new

  end

  def create
    @user = User.new(params[:user])

    if @user.save
      newBio = UserBio.new()
      newBio.user_id = @user.id
      newBio.save!

      sign_in(@user)
      redirect_to user_url(user.id)
    else
      flash[:errors] = ["invalid email and/or password"]
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:profile])
      redirect_to user_url(params[:id])
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end
end
