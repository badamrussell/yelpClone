# require 'elasticsearch'

# remember to start elasticsearch server for local testing
# elasticsearch -f

class ESQuery

  def initialize(name, local=false)
    @server = make_server(local)
    @name = name
  end

  def self.reset(name, local = false, delete_it = false)
    es_query = ESQuery.new(name, local)

    if delete_it
      es_query.delete_index(name)
      es_query.create_mapping_setup_nested
      es_query.add_businesses
    end

    return es_query
  end

  def make_server(is_local)
    if is_local
      @server = Stretcher::Server.new("http://localhost:9200")
    else
      @server = Stretcher::Server.new( ENV["BONSAI_URL"] )
    end
  end

  def delete_index(name)
    @server.index(name).delete rescue nil
  end

  def create_mapping_setup_nested
    @server.index(@name).create(
      { mappings: {
          business: {
            properties: {
              name: {
                type: "string",
                boost: 100
              },
              id: {
                type: "integer"
              },
              address1: { type: "string" },
              address2: { type: "string" },
              city: { type: "string" },
              zip_code: { type: "string" },

              rating_string: {
                type: "string"
              },

              top_review: {
                type: "object",
                body: {
                  type: "string"
                },
                user: {
                  type: "object"
                }
              },

              categories: {
                type: "object",
                name: {
                  type: "string",
                  boost: 50
                },
                main_category_id: {
                  type: "integer"
                }
              },

              business_features: {
                type: "object",
                feature_id: {
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
              },

              neighborhood: {
                type: "object",
                name: { type: "string" },
                id: { type: "integer" },

                area: {
                  type: "object",
                  name: { type: "string" }
                }
              }
            }
          }
        }
      }
    )
  end

  def add_businesses
    Business.order("id ASC").first(30).each do |b|
      add_document(b)
    end
  end

  def add_document(biz)
    puts biz.id
    @server.index(@name).type(:business).put( biz.id, JSON.parse(biz.to_elasticsearch_json) )
  end

  def server
    @server
  end

  def search(text, options = {})
    p = options[:price_range]
    n = options[:neighborhood_id]
    f = options[:feature_id]
    c = options[:category_id]
    m = options[:main_category_id]

    must_options = []

    must_options << {terms: { price_range_avg: p } } if p
    must_options << {terms: { neighborhood_id: n } } if n
    must_options << {terms: { "business_features.feature_id" => f } } if f
    must_options << {terms: { category_id: c } } if c
    must_options << {terms: { "categories.main_category_id" => m } } if m

    es_results = @server.index(@name).search({
        size: 1000,
        query: {
          bool: {

            must: must_options,

            should: [
              { match: {
                  name: text 
              }},
              { match: {
                  "top_review.body" => text 
              }},

              { term: {
                "categories.name" => text
              }}

              # { nested: {
              #   path: "reviews",
              #   query: {
              #     match: {
              #       "reviews.body" => text
              #     }
              #   }
              # }}
            ],

            minimum_should_match: 1,
          }
        },

        highlight: {
          fields: {
            name: {
              pre_tags: ['<strong class="highlight-text">'],
              post_tags: ["</strong>"],
            },
            "top_review.body" => {
              fragment_size: 200,
              pre_tags: ['<strong class="highlight-text">'],
              post_tags: ["</strong>"],
            }

            # "reviews.body" => {
            #   fragment_size: 200,
            #   pre_tags: ['<strong class="highlight-text">'],
            #   post_tags: ["</strong>"],
            # }
          }
        }
      })


    es_results.results



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