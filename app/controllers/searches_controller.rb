class SearchesController < ApplicationController

  def show
    extend SearchesHelper

    @search_params = params[:search] || {}
    @search_params[:distance] ||= "0"
    @find_desc = params[:find_desc] || ""
    @find_loc = params[:find_loc] || ""
    @category_id = params["category_id"]
    @main_category_id = params["main_category_id"]

    @link_params = @find_loc ? { find_loc: @find_loc } : {}
    @link_params[:find_desc] = @find_desc unless @find_desc == ""

    @results = rails_query(@find_desc, params, @find_loc)
    @results = Kaminari.paginate_array(@results).page(params[:page]).per(10)


    @breadcrumbs = { "Business" => search_url }
    @top_category_filter = nil
    @top_link_param = nil


    if @category_id
      crumb_category = Category.find(@category_id)
      main_name = MainCategory.find(crumb_category.main_category_id).name
      @breadcrumbs[main_name] = search_url(main_category_id: crumb_category.main_category_id)
      @breadcrumbs[crumb_category.name] = ""
    elsif @main_category_id
      main_name = MainCategory.find(params["main_category_id"]).name
      @breadcrumbs[main_name] = ""
      @top_category_filter = Category.where(main_category_id: params["main_category_id"])
      @top_link_param = :category_id
    else
      @breadcrumbs["Business"] = ""
      @top_category_filter = MainCategory.all
      @top_link_param = :main_category_id
    end

    params[:search] ||= {}

    @features = selected_features( params[:search][:feature_id] )
    @categories = selected_categories( params[:search][:category_id] )
    @neighborhoods = selected_neighborhoods( params[:search][:neighborhood_id] )
    @prices = selected_prices( params[:search][:price_range] )

    render json: @results if request.xhr?
  end

end
