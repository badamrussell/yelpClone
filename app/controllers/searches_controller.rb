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

    @results = if params[:search_type] == "es"
        Business.es_query(@find_desc, @find_loc, params[:search])
      else
        SearchQuery.new(@find_desc, @find_loc, params).uniq
      end

    @results = Kaminari.paginate_array(@results).page(params[:page]).per(10)

    @breadcrumbs, @top_category_filter, @top_link_param = make_breadcrumbs(@category_id, @main_category_id)

    params[:search] ||= {}

    id_sort = Proc.new { |a,b| a[:checked] ? -1 : (a[:checked] ? a[:id] <=> b[:id] : -1 ) }
    name_sort = Proc.new { |a,b| a[:checked] ? (b[:checked] ? a[:name] <=> b[:name] : -1 ) : 1 }

    @features = get_selected( Feature.all, params[:search][:feature_id], 5, name_sort )
    @categories = get_selected( Category.all, params[:search][:category_id], 5, name_sort )
    @neighborhoods = get_selected( Neighborhood.all, params[:search][:neighborhood_id], 5, name_sort )
    @prices = get_selected( PriceRange.all, params[:search][:price_range], 4, id_sort )

    render json: @results if request.xhr?
  end

end
