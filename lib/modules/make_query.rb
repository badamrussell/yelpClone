module MakeQuery

  def format_params_for_query(params)
    query_params = {}

    if params[:search]
      params[:search].each { |key,value| query_params[key.to_sym] = value }
    end

    query_params[:category_id] ||= [params["category_id"]] if params["category_id"]
    query_params[:main_category_id] ||= params["main_category_id"] if query_params[:category_id].nil?
    query_params[:sort] ||= params[:search]

    if @search_params[:distance].to_f > 0
      query_params[:distance] = GoogleMap.determine_bounds(current_location, @search_params[:distance].to_f)
    else
      query_params[:distance] = nil
    end

    query_params
  end

  def q_set(size)
    size.times.map { "?" }.join(",")
  end

  def make_neighborhood(params, query)
    return query unless params

    set = params.map { |n| n.to_i }

    query.where("neighborhood_id IN (#{q_set(set.length)})", *set)
  end

  def make_feature(params, query)
    return query unless params

    set = params.map { |f| f.to_i }

    query.joins("JOIN business_features ON businesses.id = business_features.business_id")
        .where("business_features.feature_id IN (#{q_set(set.length)})", *set)
  end

  def make_category(params, query)
    return query unless params

    query = query.joins("JOIN business_categories ON businesses.id = business_categories.business_id")

    if params.length == 1
      query.where("business_categories.category_id = ?", params[0].to_i)
    else
      set = params.map { |c| c.to_i }
      query.where("business_categories.category_id IN (#{q_set(set.length)})", *set)
    end
  end

  def make_main_category(params, query)
    return query unless params

    unless params
      query = query.joins("JOIN business_categories ON businesses.id = business_categories.business_id")
    end

    query.joins("JOIN categories ON categories.id = business_categories.category_id")
        .where("categories.main_category_id = ?", params)
  end

  def make_price(params, query)
    return query unless params

    set = params.map { |p| p.to_i }
    query.where("businesses.price_range_avg IN (#{q_set(set.length)})", *set)
  end

  def make_distance(params, query)
    return query unless params

    query.where("businesses.latitude BETWEEN ? AND ?", params[0], params[2])
        .where("businesses.longitude BETWEEN ? AND ?", params[3], params[1])
  end

  def build_query(query, search_params)

    query = make_neighborhood(search_params[:neighborhood_id], query)
    query = make_feature(search_params[:feature_id], query)
    query = make_category(search_params[:category_id], query)
    query = make_main_category(search_params[:main_category_id], query)
    query = make_price(search_params[:price_range], query)
    query = make_distance(search_params[:distance], query)

  end

  def build_order(query, search_string, search_params)
    rank_string = ""

    unless search_string.blank?
      query = query.where("to_tsvector('simple', coalesce(businesses.name::text, '')) @@ to_tsquery('simple', " + Business.sanitize(search_string) + ")")
                  .order("search_rank DESC")
    end

    if search_params[:sort]
      if search_params[:sort] == "rated"
        query = query.order("businesses.rating_avg DESC")
      elsif search_params[:sort] == "reviewed"
        query = query.order("businesses.reviews_count DESC")
      end
    end

    query
  end

  def rails_query(search_string, params, search_location)
    search_params = format_params_for_query(params)

    rank_string = ""
    if search_string.blank?
      rank_string = "('0')"
    else
      rank_string = "ts_rank(to_tsvector('simple', coalesce(businesses.name::text, '')), to_tsquery('simple', " + Business.sanitize(search_string) + "), 0)"
    end

    current_query = Business.select("businesses.*, #{rank_string} AS search_rank")
                    .includes(:categories, :photos, :neighborhood, :top_review)

    current_query = build_query(current_query,search_params)
    current_query = build_order(current_query, search_string, search_params)

    current_query.uniq
  end

end