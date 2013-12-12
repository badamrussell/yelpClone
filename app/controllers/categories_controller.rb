class CategoriesController < ApplicationController
  def index
    @categories = Categories.all.include(:subcategories)
  end
end
