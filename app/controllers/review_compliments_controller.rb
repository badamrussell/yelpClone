class ReviewComplimentsController < ApplicationController

  def new
    @compliment = ReviewCompliment.new
    @review = Review.find(params[:review_id])
  end

  def create
    @compliment = ReviewCompliment.new(params[:compliment])
    @compliment.user_id = current_user.id
    @review = Review.find(@compliment.review_id)

    if @compliment.save
      render json: @compliment
    else
      flash[:errors] = @compliment.errors.full_messages
      render :new
    end
  end

  def edit
    @compliment = ReviewCompliment.find(params[:id])
    @review = Review.find(@compliment.review_id)
  end

  def update
    @compliment = ReviewCompliment.find(params[:id])
    @review = Review.find(@compliment.review_id)

    if @compliment.update_attributes(params[:compliment])
      redirect_to business_url(@review.business_id)
    else
      flash[:errors] = @compliment.errors.full_messages
      render :new
    end
  end

  def destroy
    @compliment = ReviewCompliment.find(params[:id])

    @compliment.destroy

    redirect_to root_url
  end

end
