class SearchesController < ApplicationController
  include MakeQuery

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

    @breadcrumbs, @top_category_filter, @top_link_param = make_breadcrumbs(@category_id, @main_category_id)

    params[:search] ||= {}

    @features = selected_features( params[:search][:feature_id] )
    @categories = selected_categories( params[:search][:category_id] )
    @neighborhoods = selected_neighborhoods( params[:search][:neighborhood_id] )
    @prices = selected_prices( params[:search][:price_range] )

    render json: @results if request.xhr?
  end

end
