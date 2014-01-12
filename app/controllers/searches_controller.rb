class SearchesController < ApplicationController

  def show
    extend SearchesHelper

    @search_params = params[:search] || {}
    @search_params[:distance] ||= 0
    @find_desc = params[:find_desc] || ""
    @find_loc = params[:find_loc] || ""
    @category_id = params["category_id"]
    @main_category_id = params["main_category_id"]

    @link_params = @find_loc ? { find_loc: @find_loc } : {}
    @link_params[:find_desc] = @find_desc unless @find_desc == ""

    # perform query
    query_params = {}
    if params[:search]
      params[:search].each { |key,value| query_params[key.to_sym] = value }
    end
    query_params[:category_id] ||= [params["category_id"]] if params["category_id"]
    query_params[:main_category_id] ||= params["main_category_id"] if query_params[:category_id].nil?
    query_params[:sort] ||= params[:search]
    if @search_params[:distance].to_f > 0
      query_params[:distance] = determine_bounds(current_location, @search_params[:distance].to_f)
    else
      query_params[:distance] = nil
    end
    @results = rails_query(@find_desc, query_params, @find_loc)
    @results = Kaminari.paginate_array(@results).page(params[:page]).per(10)


    @breadcrumbs = { "Business" => search_url }
    @top_category_filter = nil
    @top_link_param = nil


    if @category_id
      crumb_category = Category.find(query_params[:category_id][0])
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


    @categories, @features, @neighborhoods = set_filters(params[:search])

    render json: @results if request.xhr?
  end

end
