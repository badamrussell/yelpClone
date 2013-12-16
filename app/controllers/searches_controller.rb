class SearchesController < ApplicationController
  def show
    puts "-------------- SEARCH ----------------"
    puts params[:search]
    fail
    puts "--------------------------------------"
    @breadcrumbs = { "Business" => search_url }
    @finer_filters = nil
    @finer_filter_name = nil

    @search_params = params[:search]
    if params["category_id"]
      crumb_category = Category.find(params["category_id"])
      main_name = MainCategory.find(crumb_category.id).name
      @breadcrumbs[main_name] = search_url(main_category_id: crumb_category.main_category_id)
      @breadcrumbs[crumb_category.name] = ""
    elsif params["main_category_id"]
      main_name = MainCategory.find(params["main_category_id"]).name
      @breadcrumbs[main_name] = ""
      @finer_filters = Category.where(main_category_id: params["main_category_id"])
      @finer_filter_name = :category_id
    else
      @breadcrumbs["Business"] = ""
      @finer_filters = MainCategory.all
      @finer_filter_name = :main_category_id
    end

    search_terms = {}
    params.each do |key, value|
      next if key == "action" || key == "controller" || key == "find" || key = "submit"
      search_terms[key] = value
    end



    @results = Business.search(search_terms)
    #@results = Business.all
    #@results = Business.find_from_categories(params[:c])

  end

end
