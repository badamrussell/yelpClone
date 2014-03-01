class Search

	attr_reader :results, :params, :search_type, :link_params

	ID_SORT = Proc.new { |a,b| a[:checked] ? -1 : (a[:checked] ? a[:id] <=> b[:id] : -1 ) }
	NAME_SORT = Proc.new { |a,b| a[:checked] ? (b[:checked] ? a[:name] <=> b[:name] : -1 ) : 1 }

	def initialize(params, url_proc)
		@url_proc = url_proc
		@params = params
		@params[:search] ||= {}
		@search_type = @params[:search_type] || "es"
		
		@link_params = @params[:find_loc] ? { find_loc: @find_loc } : {}
		@link_params[:find_desc] = @params[:find_desc] unless @params[:find_desc].blank?

		perform
	end

	def perform
		@results = if search_type == "pg"
		    SearchQuery.new(find_desc, find_loc, params[:search]).uniq
		  else
		    e = ESQuery.reset(:businesses_nested, false, false)
		    e.search(find_desc, params[:search])
		  end
	end

	def paginated_results
		@page_results ||= Kaminari.paginate_array(@results).page(params[:page]).per(10)
	end

	def breadcrumbs
		make_breadcrumbs if @breadcrumbs.nil?
		@breadcrumbs
	end

	def top_category_filter
		make_breadcrumbs if @top_category_filter.nil?
		@top_category_filter
	end

	def top_link_param
		make_breadcrumbs if @top_link_param.nil?
		@top_link_param
	end

	def find_desc
		@params[:find_desc] || ""
	end

	def find_loc
		@params[:find_loc] || ""
	end

	def search_type
		@params[:search_type] || "pg"
	end

	def category_id
		@params["category_id"]
	end

	def main_category_id
		@params["main_category_id"]
	end

	def features
		get_selected( Feature.all, @params[:search][:feature_id], 5, NAME_SORT )
	end

	def categories
		get_selected( Category.all, @params[:search][:category_id], 5, NAME_SORT )
	end

	def neighborhoods
		get_selected( Neighborhood.all, @params[:search][:neighborhood_id], 5, NAME_SORT )
	end

	def prices
		get_selected( PriceRange.all, @params[:search][:price_range], 4, ID_SORT )
	end

	def location
		puts find_loc
		find_loc.blank? ? City.order(:id).first.name : City.find(find_loc).name
	end

	def sorted
		@params[:search][:sort] || ""
	end

	def distance
		@params[:search][:distance] || "0"
	end

	def is_distance?(dist)
		dist == distance
	end


  private


  def make_breadcrumbs
    @breadcrumbs = { "Business" => @url_proc.call(nil) }
    @top_category_filter = nil
    @top_link_param = nil

    if category_id
      crumb_category = Category.find(category_id)
      main_name = MainCategory.find(crumb_category.main_category_id).name
      @breadcrumbs[main_name] = @url_proc.call(main_category_id: crumb_category.main_category_id)
      @breadcrumbs[crumb_category.name] = ""
    elsif main_category_id
      main_name = MainCategory.find(main_category_id).name
      @breadcrumbs[main_name] = ""
      @top_category_filter = Category.where(main_category_id: main_category_id)
      @top_link_param = :category_id
    else
      @breadcrumbs["Business"] = ""
      @top_category_filter = MainCategory.all
      @top_link_param = :main_category_id
    end
  end

  def get_selected(objs, set, size, proc)
    list = objs.map { |item| { name: item.name, id: item.id, checked: false, visible: false } }

    gather_filter_settings(set, list, size, proc)
  end

  def gather_filter_settings(set=nil, list, visible_limit, proc)
    set ||= []

    extra_count = visible_limit - set.length

    new_set = list.select { |item| set.include?(item[:id].to_s) }
    extra_items = (list - new_set)[0, extra_count]

    new_set.each { |item| item[:checked] = true }
    new_set += extra_items

    visible_limit.times do |index|
    	break if index >= new_set.length
    	new_set[index][:visible] = true
    end

    new_set.sort &proc
  end
  
end