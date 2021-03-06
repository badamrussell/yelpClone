class SearchQuery

  def initialize(search_string, search_location, params)
    @search_string = search_string
    rank_string = ranking(search_string)



    @query = Business.select("businesses.*, #{rank_string} AS search_rank")
                    .includes(:photos, :neighborhood)

    search_params = format_params_for_query(params)

    where(search_params[:neighborhood_id], "neighborhood_id")
    where(search_params[:feature_id], "business_features.feature_id")
    where_category(search_params[:category_id])
    where(search_params[:price_range], "businesses.price_range_avg")

    join(search_params[:feature_id], "business_features")
    # join(search_params[:category_id], "business_categories")
    # join(search_params[:main_category_id], "business_categories")

    tsvector(search_string)

    main_category(search_params[:main_category_id])
    distance(search_params[:distance])

    order(search_params[:sort])
  end

  def query
    @query
  end

  def uniq
    @query.uniq
  end



  private

  def where_category(params)
    return nil unless params

    set = params[0].map { |n| n.to_i }
    @query = @query.where("businesses.category1_id IN (?) OR businesses.category2_id IN (?) OR businesses.category3_id IN (?)", set, set, set)
  end

  def where(params, name)
    return nil unless params

    set = params.map { |n| n.to_i }
    @query = @query.where("#{name} IN (#{q_set(set.length)})", *set)
  end

  def join(params, name)
    return nil unless params

    @query = @query.joins("JOIN #{name} ON businesses.id = #{name}.business_id")
  end

  def main_category(params)
    return nil unless params
    # @query = @query.joins("JOIN categories ON categories.id = business_categories.category_id")
                  # .where("categories.main_category_id = ?", params)
    @query = @query.joins("JOIN categories as c1 ON c1.id = businesses.category1_id")
                  .joins("JOIN categories as c2 ON c2.id = businesses.category2_id")
                  .joins("JOIN categories as c3 ON c3.id = businesses.category3_id")
                  .where("c1.main_category_id = ? OR c2.main_category_id = ? OR c3.main_category_id = ?", params, params, params)
  end

  def distance(params)
    return nil unless params

    @query = @query.where("businesses.latitude BETWEEN ? AND ?", params[0], params[2])
                  .where("businesses.longitude BETWEEN ? AND ?", params[3], params[1])
  end

  def tsvector(search_string)
    return nil if search_string.blank?

    str = Business.sanitize(search_string.gsub(","," "))

    @query = @query.where("to_tsvector('english', coalesce(businesses.name::text, '')) @@ to_tsquery('english', " + format_search_string + ")")
    #@query = @query.where("businesses.name @@ #{s_string}")
  end

  def order(params)
    return nil if params.nil?

    if params == "rated"
      @query = @query.order("businesses.rating_avg DESC")
    elsif params == "reviewed"
      @query = @query.order("businesses.reviews_count DESC")
    else
       @query = @query.order("search_rank DESC")
    end
  end

  def format_search_string
    Business.sanitize(@search_string.gsub(","," ").split(" ").join(" | "))
  end

  def ranking(search_string)
    if search_string.blank?
      "('0')"
    else
      "ts_rank(to_tsvector('simple', coalesce(businesses.name::text, '')), to_tsquery('simple', " + format_search_string + "), 0)"
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