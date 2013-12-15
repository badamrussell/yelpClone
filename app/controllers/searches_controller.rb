class SearchesController < ApplicationController
  def show
    search_terms = {}
    params.each do |key, value|
      next if key == "action" || key == "controller"
      search_terms[key] = value
    end

    @results = Business.search(search_terms)
    #@results = Business.all
    #@results = Business.find_from_categories(params[:c])

  end
end
