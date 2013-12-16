class ListsController < ApplicationController

  def index
    @lists = User.find(params[:user_id]).lists
  end

  def show
    @list = List.params[:id]
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.new(params[:list])

    if @list.save
      redirect_to list_url(@list.id)
    else
      flash[:errors] = @list.errors.full_messages
      render :new
    end
  end

  def destroy
    @list.find(params[:id])

    @list.destroy
    flash[:errors] = @list.errors.full_messages

    redirect_to lists_url
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])

    if @list.update_attributes(params[:list])
      redirect_to lists_url
    else
      flash[:errors] = @list.errors.full_messages
      render :edit
    end
  end

end
