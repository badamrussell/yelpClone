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

  def get_selected(objs, set, size, &proc)
    proc ||= Proc.new { |a,b| a[:checked] ? (b[:checked] ? a[:name] <=> b[:name] : -1 ) : 1 }

    list = objs.map { |item| { name: item.name, id: item.id, checked: false, visible: false } }

    gather_filter_settings(set, list, size, proc)
  end

  def gather_filter_settings(set = nil, list, visible_limit, proc)
    set ||= []

    extra_count = visible_limit - set.length

    new_set = list.select { |item| set.include?(item[:id].to_s) }
    extra_items = (list - new_set)[0, extra_count]

    new_set.each { |item| item[:checked] = true }
    new_set += extra_items

    visible_limit.times { |index| new_set[index][:visible] = true }

    new_set.sort &proc
  end

end
