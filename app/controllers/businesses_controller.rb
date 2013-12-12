class BusinessesController < ApplicationController
  def show
    @business = Business.find(params[:id])
  end

  def new
    @business = Business.new()
  end

  def create
    @business = Business.new(params[:business])

    if @business.save
      redirect_to business_url(@business.id)
    else
      flash[:errors] = @businesses.errors.full_messages
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

    if @params.update_attributes(params[:business])

      redirect_to business_url(@business.id)
    else
      flash[:errors] = @business.errors.full_messages
      render :edit
    end

  end
end
