class ReviewComplimentsController < ApplicationController

  def new
    @compliment = ReviewCompliment.new
    @review = Review.find(params[:review_id])
  end

  def create
    params[:compliment].merge!(user_id: current_user.id)
    @compliment = ReviewCompliment.create(params[:compliment])
    @review = Review.find(@compliment.review_id)

    puts params
    puts @compliment
    puts @compliment.valid?
    puts "-----------------------"
    flash[:errors] = @compliment.errors.full_messages

    if request.xhr?
      render json: @compliment
    else

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

  def show
    @user = User.find(params[:id])
  end
end
