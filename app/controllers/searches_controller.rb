class SearchesController < ApplicationController

    def show
    		urlProc = Proc.new { |val| search_url(val) }
        @search = Search.new(params, urlProc )
        render json: @search.paginated_results if request.xhr?
    end

end
