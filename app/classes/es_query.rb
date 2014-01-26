# require 'elasticsearch'

# remember to start elasticsearch server for local testing
# elasticsearch -f

class ESQuery

  def initialize
    @server = Stretcher::Server.new("http://localhost:9200")
    # @client = Elasticsearch::Client.new log: true
    @server.index(:foo).delete rescue nil
    @server.index(:foo).create( mapping_setup_nested )

    add_businesses
  end

  def mapping_setup_nested
    { mappings: {
        business: {
          properties: {
            name: {
              type: "string",
              boost: 100
            },
            
            categories: {
              type: "object",
              name: {
                type: "string",
                boost: 50
              }
            },

            business_features: {
              type: "object",
              id: {
                type: "integer",
                boost: 10
              }
            },

            reviews: {
              type: "nested",
              body: { type: "string" },
              id: { type: "integer" }
            },

            location: {
              type: "geo_point",
              precision: "1m"
            }
          }
        }

        # reviews: {
        #   properties: {
        #     body: {
        #       type: "string"
        #     },

        #     business_id: {
        #       type: "integer"
        #     }
        #   }
        # }
      }
    }
  end

  def add_businesses
    Business.order("id ASC").first(10).each do |b|
      add_document(b)
    end
  end

  def add_document(biz)
    puts biz.id
    @server.index(:foo).type(:business).put( biz.id, JSON.parse(biz.to_indexed_json) )
  end


  def search(text)
    # @server.index(:foo).search({
    #     size: 1000,
    #     query: {
    #       multi_match: {
    #         query: text,
    #         fields: ["name", "categories.name", "reviews.body"]
    #       }
    #     },
    #     query: {
    #       nested: {
    #         path: "reviews",
    #         query: {
    #           match: {
    #             "reviews.body" => "page"
    #           }
    #         }
    #       }
    #     }
    #   })

    # @server.index(:foo).search({
    #     size: 1000,
    #     query: {
    #       bool: {
    #         must: [
    #           { terms: {
    #               "business_features.feature_id" => [13]
    #           }},
    #           { terms: {
    #               "categories.id" => [13]
    #           }},
    #           { terms: {
    #               neighborhood_id: [13]
    #           }},
    #           { terms: {
    #               price_range_avg: [13]
    #           }},
    #         ],

    #         minimum_should_match: 1,
    #         should: [
    #           { match: {
    #               name: text 
    #           }},

    #           { term: {
    #             "categories.name" => text
    #           }},

    #           { nested: {
    #             path: "reviews",
    #             query: {
    #               match: {
    #                 "reviews.body" => text
    #               }
    #             }
    #           }}
    #         ]
    #       }
    #     }





  #     {
  #   "query" : {
  #     "multi_match" : {
  #       "query": "afghan",
  #       "fields": ["name","categories.name"]
  #     }
  #   },
  #   "query" : {
  #     "nested" : {
  #       "path" : "reviews",
  #       "query" : {
  #         "match" : {
  #           "reviews.body" : "afghan"
  #         }
  #       }
  #     }
  #   }
  # }
  end

  # def query(search_string, distance, center, options = {})
  #   options ||= {}

  #   p = options[:price_range]
  #   n = options[:neighborhood_id]
  #   f = options[:feature_id]
  #   c = options[:category_id]
  #   m = options[:main_category_id]

  #   Business.search do
  #     query { match [:name, "top_review.body"], search_string } unless search_string.blank?

  #     filter :terms, price_range_avg: p if p
  #     filter :terms, neighborhood_id: n if n
  #     filter :terms, "business_features.feature_id" => f if f
  #     filter :terms, "categories.id" => c if c
  #     filter :terms, "categories.main_category_id" => m if m
  #     highlight "name", "top_review.body", options: { tag: '<strong class="highlight-text">', fragment_size: 200 }
  #   end

  # end

  # include Tire::Model::Search
  # include Tire::Model::Callbacks

  # self.include_root_in_json = false

  # mapping do
  #   indexes :name, boost: 100

  #   indexes :neighborhood_id, type: "integer", index: :not_analyzed
  #   indexes :price_range_avg, type: "integer", index: :not_analyzed
  #   indexes :latitude, type: "float", index: :not_analyzed
  #   indexes :longitude, type: "float", index: :not_analyzed


  #   indexes :business_features do
  #     indexes :feature_id, type: "integer", index: :not_analyzed
  #   end

  #   indexes :business_categories do
  #     indexes :category_id, type: "integer", index: :not_analyzed
  #     indexes :main_category_id, type: "integer", index: :not_analyzed
  #   end

  #   indexes :reviews do
  #     indexes :body
  #   end

  #   indexes :top_review do
  #     indexes :body
  #   end
  # end


  # def self.es_query(search_string, distance, center, options = {})
  #   options ||= {}

  #   p = options[:price_range]
  #   n = options[:neighborhood_id]
  #   f = options[:feature_id]
  #   c = options[:category_id]
  #   m = options[:main_category_id]

  #   Business.search do
  #     query { match [:name, "top_review.body"], search_string } unless search_string.blank?

  #     filter :terms, price_range_avg: p if p
  #     filter :terms, neighborhood_id: n if n
  #     filter :terms, "business_features.feature_id" => f if f
  #     filter :terms, "categories.id" => c if c
  #     filter :terms, "categories.main_category_id" => m if m
  #     highlight "name", "top_review.body", options: { tag: '<strong class="highlight-text">', fragment_size: 200 }
  #   end
  # end

end