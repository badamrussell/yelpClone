class TipsController < ApplicationController

  def index
    @tips = User.find(params[:user_id]).tips
  end

  def show
    @tips = Tip.find.params[:id]
  end

  def new
    @tips = Tip.new
  end

  def create
    @tips = current_user.tips.new(params[:tips])

    if @tips.save
      redirect_to tips_url(@tips.id)
    else
      flash[:errors] = @tips.errors.full_messages
      render :new
    end
  end

  def destroy
    @tips.find(params[:id])

    @tips.destroy
    flash[:errors] = @tips.errors.full_messages

    redirect_to tips_url
  end

  def edit
    @tips = Tip.find(params[:id])
  end

  def update
    @tips = Tip.find(params[:id])

    if @tips.update_attributes(params[:tips])
      redirect_to tips_url
    else
      flash[:errors] = @tips.errors.full_messages
      render :edit
    end
  end

end
