class SearchQuery

  def initialize(search_string, params, search_location)
    rank_string = ranking(search_string)

    @query = Business.select("businesses.*, #{rank_string} AS search_rank")
                    .includes(:categories, :photos, :neighborhood, :top_review)

    search_params = format_params_for_query(params)

    neighborhood(search_params[:neighborhood_id])
    feature(search_params[:feature_id])
    category(search_params[:category_id])
    main_category(search_params[:main_category_id])
    price(search_params[:price_range])
    distance(search_params[:distance])

    order(search_string, search_params[:sort])
  end

  def uniq
    @query.uniq
  end

  private

  def neighborhood(params)
    return nil unless params

    set = params.map { |n| n.to_i }
    @query = @query.where("neighborhood_id IN (#{q_set(set.length)})", *set)
  end

  def feature(params)
    return nil unless params

    set = params.map { |f| f.to_i }
    @query = @query.joins("JOIN business_features ON businesses.id = business_features.business_id")
        .where("business_features.feature_id IN (#{q_set(set.length)})", *set)
  end

  def category(params)
    return nil unless params

    set = params.map { |c| c.to_i }
    @query = @query.joins("JOIN business_categories ON businesses.id = business_categories.business_id")
                  .where("business_categories.category_id IN (#{q_set(set.length)})", *set)
  end

  def main_category(params)
    return nil unless params

    unless params
      @query = @query.joins("JOIN business_categories ON businesses.id = business_categories.business_id")
    end

    @query = @query.joins("JOIN categories ON categories.id = business_categories.category_id")
                  .where("categories.main_category_id = ?", params)
  end

  def price(params)
    return nil unless params

    set = params.map { |p| p.to_i }
    @query = @query.where("businesses.price_range_avg IN (#{q_set(set.length)})", *set)
  end

  def distance(params)
    return nil unless params

    @query = @query.where("businesses.latitude BETWEEN ? AND ?", params[0], params[2])
                  .where("businesses.longitude BETWEEN ? AND ?", params[3], params[1])
  end

  def order(search_string, params)
    return nil if params.blank?

    unless search_string.blank?
      @query = @query.where("to_tsvector('simple', coalesce(businesses.name::text, '')) @@ to_tsquery('simple', " + Business.sanitize(search_string) + ")")
                  .order("search_rank DESC")
    end

    if params == "rated"
      @query = @query.order("businesses.rating_avg DESC")
    elsif params == "reviewed"
      @query = @query.order("businesses.reviews_count DESC")
    end
  end

  def ranking(search_string)
    if search_string.blank?
      "('0')"
    else
      "ts_rank(to_tsvector('simple', coalesce(businesses.name::text, '')), to_tsquery('simple', " + Business.sanitize(search_string) + "), 0)"
    end
  end

  def format_params_for_query(params)
    query_params = {}

    if params[:search]
      params[:search].each { |key,value| query_params[key.to_sym] = value }
    end

    query_params[:category_id] ||= [params["category_id"]] if params["category_id"]
    query_params[:main_category_id] ||= params["main_category_id"] if query_params[:category_id].nil?
    query_params[:sort] ||= params[:search]

    if params[:distance].to_f > 0
      query_params[:distance] = GoogleMap.determine_bounds(current_location, @search_params[:distance].to_f)
    else
      query_params[:distance] = nil
    end

    query_params
  end

  def q_set(size)
    size.times.map { "?" }.join(",")
  end

end