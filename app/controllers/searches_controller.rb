class SearchesController < ApplicationController

  def gather_filter_settings(set, list, visible_limit)

    if set
      set = set.map { |a| a.to_i }

      list.each do |item|
        if set.include?(item[:id])
          item[:checked] = true

          if @categories.count { |c| c[:checked] } <= visible_limit
            item[:visible] = true
          end
        end
      end
    end

    while list.count { |item| item[:visible] } < visible_limit
      list.select { |invis_item| !invis_item[:visible] }[0][:visible] = true
    end
  end

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
    @saved_params = @find_loc ? { find_loc: @find_loc } : {}
    @saved_params[:find_desc] = @find_desc unless @find_desc == ""

    @categories = Category.all.map { |cat| { name: cat.name, id: cat.id, checked: false, visible: false } }
    @features = Feature.all.map { |feat| { name: feat.name, id: feat.id, checked: false, visible: false } }
    @neighborhoods = Neighborhood.all.map { |neigh| {name: neigh.name, id: neigh.id, checked: false, visible: false } }

    query_params = {}
    if params[:search]
      params[:search].each { |key,value| query_params[key.to_sym] = value }
    end

    query_params[:category_id] ||= [params["category_id"]] if params["category_id"]
    query_params[:main_category_id] ||= params["main_category_id"] if query_params[:category_id].nil?
    query_params[:sort] ||= params[:search]

    if @search_params[:distance] && @search_params[:distance].to_f > 0
      query_params[:distance] = determine_bounds(current_location, @search_params[:distance].to_f)
    else
      query_params[:distance] = nil
    end


    if params["category_id"]
      crumb_category = Category.find(query_params[:category_id][0])
      main_name = MainCategory.find(crumb_category.main_category_id).name
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

    set = params[:search] ? params[:search][:category_id] : []
    gather_filter_settings(set, @categories, 5)

    set = params[:search] ? params[:search][:feature_id] : []
    gather_filter_settings(set, @features, 5)

    set = params[:search] ? params[:search][:neighborhood_id] : []
    gather_filter_settings(set, @neighborhoods, 5)

    @search_params[:distance] ||= 0

    @results = rails_query(@find_desc, query_params, @find_loc)
    @results = Kaminari.paginate_array(@results).page(params[:page]).per(10)

    render json: @results if request.xhr?
  end

  def nearby


  end


end
