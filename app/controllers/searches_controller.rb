class SearchesController < ApplicationController
  def new
    @results = Business.all
  end
end
