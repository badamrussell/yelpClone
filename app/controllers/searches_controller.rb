class SearchesController < ApplicationController
  def show
    @breadcrumbs = { "Business" => search_url }
    @finer_filters = nil

    if params["category_id"]
      crumb_category = Category.find(params["category_id"])
      main_name = MainCategory.find(crumb_category.id).name
      @breadcrumbs[main_name] = search_url(main_category_id: crumb_category.main_category_id)
      @breadcrumbs[crumb_category.name] = ""
    elsif params["main_category_id"]
      main_name = MainCategory.find(params["main_category_id"]).name
      @breadcrumbs[main_name] = ""
      @finer_filters = Category.where(main_category_id: params["main_category_id"])
    else
      @breadcrumbs["Business"] = ""
      @finer_filters = MainCategory.all
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
