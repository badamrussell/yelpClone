class UsersController < ApplicationController
  before_filter :require_current_user!, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.includes(:photos, :bio).find(params[:id])
    @reviews = @user.reviews

    unless @user
      flash[:errors] = @user.errors.messages
      redirect_to users_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in(@user)

      flash[:success] = ["Welcome to Yelp Clone!"]
      redirect_to user_url(@user.id)
    else
      flash[:errors] = ["invalid email and/or password"]
      render :new
    end
  end

  def edit
    redirect_to edit_profile_url
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

  def home
    @reviews = Review.recent(10)
  end
end
