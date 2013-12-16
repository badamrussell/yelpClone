class ReviewComplimentsController < ApplicationController

  def new
    @compliment = ReviewCompliment.new
    @review = Review.find(params[:review_id])
  end

  def create
    @compliment = current_user.review_compliments.new(params[:compliment])
    @review = Review.find(@compliment.review_id)

    if @compliment.save
      redirect_to user_url(@review.user.id)
    else
      flash[:errors] = @compliment.errors.full_messages
      render :new
    end
  end

  def edit
    @compliment = ReviewCompliment.find(params[:id])
  end

  def update
    @compliment = ReviewCompliment.find(params[:id])

    if @compliment.update_attributes(params[:compliment])
      redirect_to user_url(@review.user.id)
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
