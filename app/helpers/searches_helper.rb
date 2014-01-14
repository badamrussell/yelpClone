module SearchesHelper

  def make_breadcrumbs(category_id, main_category_id)
    crumbs = { "Business" => search_url }
    top_category_filter = nil
    top_link_param = nil

    if category_id
      crumb_category = Category.find(category_id)
      main_name = MainCategory.find(crumb_category.main_category_id).name
      crumbs[main_name] = search_url(main_category_id: crumb_category.main_category_id)
      crumbs[crumb_category.name] = ""
    elsif main_category_id
      main_name = MainCategory.find(main_category_id).name
      crumbs[main_name] = ""
      top_category_filter = Category.where(main_category_id: main_category_id)
      top_link_param = :category_id
    else
      crumbs["Business"] = ""
      top_category_filter = MainCategory.all
      top_link_param = :main_category_id
    end

    [crumbs, top_category_filter, top_link_param]
  end

  def format_params_for_query(params)

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

    query_params
  end

  def selected_categories(set = nil)
    set ||= []
    category_list = Category.all.map { |cat| { name: cat.name, id: cat.id, checked: false, visible: false } }

    gather_filter_settings(set, category_list, 5)
  end

  def selected_features(set = nil)
    set ||= []
    feature_list = Feature.all.map { |feat| { name: feat.name, id: feat.id, checked: false, visible: false } }

    gather_filter_settings(set, feature_list, 5)
  end

  def selected_neighborhoods(set = nil)
    set ||= []
    neighborhood_list = Neighborhood.all.map { |neigh| {name: neigh.name, id: neigh.id, checked: false, visible: false } }

    gather_filter_settings(set, neighborhood_list, 5)
  end

  def selected_prices(set = nil)
    set ||= []

    PriceRange.all.map do |p|
      {name: p.name, id: p.id, checked: set.include?(p.id.to_s), visible: true }
    end
  end

  def gather_filter_settings(set, list, visible_limit)
    new_set = []

    visible_count = 0

    if set
      extra_items = visible_limit - set.length
      set = set.map { |a| a.to_i }

      list.each do |item|
        if set.include?(item[:id])
          item[:checked] = true
          new_set << item

          if visible_count <= visible_limit
            item[:visible] = true
            visible_count += 1
          end
        elsif extra_items > 0
          item[:visible] = true
          new_set << item

          visible_count += 1
          extra_items -= 1
        end
      end
    else
      new_set = list[0...visible_limit]
      new_set.each { |a| a[:visible] = true }
    end

    new_set.sort { |a,b| a[:checked] ? (b[:checked] ? a[:name] <=> b[:name] : -1 ) : 1 }
  end


  def determine_bounds(center, miles_offset)
    # calculates ne and sw corner
    # SW-74.069, 40.710
    # NE -73.86, 40.866

    lng_offset = miles_offset / 69.0
    lat_offset = miles_offset / 53.0
    bounds = []
    bounds << center[:lat] - lat_offset
    bounds << center[:lng] + lng_offset
    bounds << center[:lat] + lat_offset
    bounds << center[:lng] - lng_offset

    bounds
  end

  def split_string
    word_spaced = search_params[:find].split(" ")

    words = []
    word_spaced.each do |w|
      if w.index(",")
        word += w.split(",")
      else
        words << w
      end
    end

    words
  end

  def q_set(size)
    size.times.map { "?" }.join(",")
  end

  def make_where

  end

  def make_joins

  end

  def make_neighborhood(params, where_string, values)
    if params
      set = params.map { |n| n.to_i }
      set.each { |s| values << s }

      where_string << " AND " unless where_string.blank?
      where_string << "neighborhood_id IN (#{q_set(set.length)})"
    end
  end

  def make_feature(params, joins, wheres, values)
    return nil unless params

    joins << "JOIN business_features ON businesses.id = business_features.business_id"
    set = params.map { |f| f.to_i }
    wheres << "business_features.feature_id IN (#{q_set(set.length)})"
    set.each { |s| values << s }
  end

  def make_category(params, joins, wheres, values)
    return nil unless params

    joins << "JOIN business_categories ON businesses.id = business_categories.business_id"
    if params.length == 1
      wheres << "business_categories.category_id = ?"
      values << params[0].to_i
    else
      set = params.map { |c| c.to_i }
      wheres << "business_categories.category_id IN (#{q_set(set.length)})"
      set.each { |s| values << s }
    end
  end

  def make_main_category(params, joins, wheres, values)
    return nil unless params

    unless params
      joins << "JOIN business_categories ON businesses.id = business_categories.business_id"
    end
    joins << "JOIN categories ON categories.id = business_categories.category_id"

    wheres << "categories.main_category_id = ?"
    values << params
  end

  def make_price(params, wheres, values)
    return nil unless params

    set = params.map { |p| p.to_i }

    wheres << " businesses.price_range_avg IN (#{q_set(set.length)})"

    set.each { |s| values << s }
  end

  def make_distance(params, wheres, values)
    return nil unless params

    wheres << "businesses.latitude BETWEEN ? AND ?"
    wheres << "businesses.longitude BETWEEN ? AND ?"

    values << params[0]
    values << params[2]
    values << params[3]
    values << params[1]
  end


  def rails_query(search_string, params, search_location)
    search_params = format_params_for_query(params)

    wheres = []
    joins = []
    values = []
    orders = []

    rank_string = ""
    where_string = ""
    order_string = ""

    if search_string.blank?
      rank_string ="('0')"
    else
      rank_string = "ts_rank(to_tsvector('simple', coalesce(businesses.name::text, '')), to_tsquery('simple', " + Business.sanitize(search_string) + "), 0)"
      where_string << "to_tsvector('simple', coalesce(businesses.name::text, '')) @@ to_tsquery('simple', " + Business.sanitize(search_string) + ")"
      orders << "search_rank DESC"
    end

    make_neighborhood(search_params[:neighborhood_id], where_string, values)
    make_feature(search_params[:feature_id], joins, wheres, values)
    make_category(search_params[:category_id], joins, wheres, values)
    make_main_category(search_params[:main_category_id], joins, wheres, values)
    make_price(search_params[:price_range], wheres, values)
    make_distance(search_params[:distance], wheres, values)

    if search_params[:sort]
      if search_params[:sort] == "rated"
        orders.unshift("businesses.rating_avg DESC")
      elsif search_params[:sort] == "reviewed"
        orders.unshift("businesses.reviews_count DESC")
      end
    end

    if !wheres.blank?
      where_string << " AND " unless where_string.blank?
      where_string << "(#{wheres.join(" AND ")})"
    end

    join_string = joins.join(" ")
    order_string = "#{orders.join(',')}" if orders.any?

    Business.select("businesses.*, #{rank_string} AS search_rank")
            .includes(:categories, :photos, :neighborhood, :top_review)
            .joins(join_string)
            .where(where_string, *values)
            .order(order_string)
            .uniq
  end

end
