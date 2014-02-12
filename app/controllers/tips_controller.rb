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
    create_action(@tips, tips_url(@tips.id))
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
    update_action(@tips, params[:tips], tips_url)
  end

end
