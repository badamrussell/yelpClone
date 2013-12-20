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
    @recommend_categories = Category.all[1..3]
    @find_desc = params[:find_desc] || ""
    @find_loc = params[:find_loc] || ""
    @category_id = params["category_id"]
    @saved_params = @find_loc ? {find_loc: @find_loc} : {}
    @saved_params[:find_desc] = @find_desc unless @find_desc == ""
    @select_categories = []
    @select_features = []
    @select_neighborhoods = []

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

    @results = @find_desc.blank? ? Business : Business.search_by_name(@find_desc)
    p_s = params[:search] || {}

    unless params[:search].nil?

    end

    @results = rails_query(@results, p_s, @find_loc)
    if @search_params && @search_params.any?
      #find categories to display (top 5)
      if params[:search][:category_id]
        @select_categories = params[:search][:category_id].map { |num| Category.find(num) }
      end
      if params[:search][:feature_id]
        @select_features = params[:search][:feature_id].map { |num| Feature.find(num) }
      end

      if params[:search][:neighborhood_id]
        @select_neighborhoods = params[:search][:neighborhood_id].map { |num| Neighborhood.find(num) }
      end
    end

    @results = Kaminari.paginate_array(@results).page(params[:page]).per(10)

    # @results = if @search_params && @search_params.any?
    #   #find categories to display (top 5)
    #   if params[:search][:category_id]
    #     @select_categories = params[:search][:category_id].map { |num| Category.find(num) }
    #   end
    #   if params[:search][:feature_id]
    #     @select_features = params[:search][:feature_id].map { |num| Feature.find(num) }
    #   end
    #
    #   if params[:search][:neighborhood_id]
    #     @select_neighborhoods = params[:search][:neighborhood_id].map { |num| Neighborhood.find(num) }
    #   end
    #
    #   q = make_query(params[:search], @find_desc, @find_loc ) if params[:search]
    #   Kaminari.paginate_array(q).page(params[:page]).per(10)
      # box = Geocoder::Calculations.bounding_box(current_location, 20)
      #
      # biz_within_range = Business.within_bounding_box(box)
      # fail

    # else
    #   search_terms =  if params["category_id"]
    #                     { "category_id" => params["category_id"] }
    #                   elsif params["main_category_id"]
    #                     { "main_category_id" => params["main_category_id"] }
    #                   else
    #                     {}
    #                   end
    #
    #   # Business.search(search_terms).page(params[:page])
    #
    #   Kaminari.paginate_array(Business.all).page(params[:page]).per(10)
    # end
  end

  def nearby


  end

end
