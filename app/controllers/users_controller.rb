class UsersController < ApplicationController
  before_filter :require_current_user!, only: [:edit, :update]

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

      neighborhood = Area.determine_neighborhood()
      newLocation = @user.profile_locations.create(address: neighborhood, name: "Home", primary: true)

      sign_in(@user)
      redirect_to user_url(@user.id)
    else
      flash[:errors] = ["invalid email and/or password"]
      render :new
    end
  end

  def edit
    # @user = User.find(params[:id])
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
