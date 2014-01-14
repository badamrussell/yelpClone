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

  def gather_filter_settings(set = nil, list, visible_limit)
    set ||= []

    extra_count = visible_limit - set.length

    new_set = list.select { |item| set.include?(item[:id].to_s) }
    extra_items = (list - new_set)[0, extra_count]

    new_set.each { |item| item[:checked] = true }
    new_set += extra_items

    visible_limit.times { |index| new_set[index][:visible] = true }


    new_set.sort { |a,b| a[:checked] ? (b[:checked] ? a[:name] <=> b[:name] : -1 ) : 1 }
  end

end
