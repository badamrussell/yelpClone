class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper, VotesHelper


  def create_action(model_item, url)
    if model_item.save
      redirect_to url
    else
      flash[:errors] = model_item.errors.full_messages
      render :new
    end
  end

  def update_action(model_item, param_items, url)
    if model_item.update_attributes(param_items)
      flash[:success] = ["#{model_item.name} was updated!"]
      redirect_to url
    else
      flash[:errors] = model_item.errors.full_messages
      render :edit
    end
  end
  
end
