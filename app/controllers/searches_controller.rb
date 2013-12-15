class SearchesController < ApplicationController
  def show
    @breadcrumbs = { "Business" => search_url }

    if params["category_id"]
      crumb_category = Category.find(params["category_id"])
      @breadcrumbs[MainCategory.find(crumb_category.id).name] = search_url(main_category_id: crumb_category.main_category_id)
      @breadcrumbs[crumb_category.name] = ""
    end

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
