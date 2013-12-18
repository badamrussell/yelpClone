class SearchesController < ApplicationController
  def show
    #search elements
    # find, near
    # sort, distance, neighborhoods, price, features, categories
    extend SearchesHelper


    @breadcrumbs = { "Business" => search_url }
    @finer_filters = nil
    @finer_filter_name = nil

    @search_params = params[:search] || {}


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

    @results = if @search_params && @search_params.any?
      make_query(params[:search]) if params[:search]
      # box = Geocoder::Calculations.bounding_box(current_location, 20)
      #
      # biz_within_range = Business.within_bounding_box(box)
      # fail

    else
      search_terms =  if params["category_id"]
                        { "category_id" => params["category_id"] }
                      elsif params["main_category_id"]
                        { "main_category_id" => params["main_category_id"] }
                      else
                        {}
                      end

      Business.search(search_terms)
    end
  end

  def nearby


  end

end
