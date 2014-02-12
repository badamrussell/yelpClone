class BusinessesController < ApplicationController
  # include GoogleMap

  before_filter :require_current_user!, except: [:show]

  def show
    @business = Business.includes(:business_features).find(params[:id])
    @reviews = Kaminari.paginate_array(@business.reviews.order("updated_at DESC")).page(params[:page]).per(4)

    @best_businesses = Category.best_businesses(5, @business.categories.pluck(:id))
  end

  def new
    @business = Business.new
    @review = Review.new
    @photo = Photo.new
  end

  def create
    flash[:errors] = []
    @business = Business.new(params[:business])

    params[:review].merge!( user_id: current_user.id )
    params[:photo].merge!( user_id: current_user.id )

    flash[:errors] = @business.creation_transaction(params[:review], params[:photo])


    if flash[:errors].empty?
      redirect_to business_url(@business.id)
    else
      @review = Review.new(params[:review])
      @photo = Photo.new(params[:photo])
      render :new
    end
  end

  def destroy

  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    @business = Business.find(params[:id])
    update_action(@business, params[:business], business_url(@business.id))
  end

end
