class BusinessesController < ApplicationController
  before_filter :require_current_user!, except: [:show]

  def show
    @business = Business.includes(:business_hours, :business_features).find(params[:id])
    @best_businesses = Category.best_businesses(5, @business.categories)
    # @best_businesses = Business.includes(:neighborhood, :store_front_photo).best(@business.categories)
  end

  def new
    @business = Business.new()
  end

  def create
    flash[:errors] = []
    @business = Business.new(params[:business])
    @review = current_user.reviews.new(params[:review])

    ActiveRecord::Base.transaction do
      @business.save

      @review.business_id = @business.id

      @review.save unless params[:review][:body].blank? && params[:review][:rating].blank?


      flash[:errors] += @business.errors.full_messages
      flash[:errors] += @review.errors.full_messages
    end

    if flash[:errors].empty?
      redirect_to business_url(@business.id)
    else
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

    if @business.update_attributes(params[:business])

      redirect_to business_url(@business.id)
    else
      flash[:errors] = @business.errors.full_messages
      render :edit
    end

  end
end
