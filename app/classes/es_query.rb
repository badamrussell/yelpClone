# require 'elasticsearch'

# remember to start elasticsearch server for local testing
# elasticsearch -f
# ui : http://localhost:9200/_plugin/head/

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
              reviews_count: { type: "integer" },
              longitude: { type: "float" },
              latitude: { type: "float"},

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

  def business_json(biz)
    biz.to_json( include: { top_review: { only: [:body], methods: [:user_avatar] },
                        neighborhood: { include: :area },
                        business_features: { only: [:feature_id] },
                        # reviews: { only: [:id, :body] }
                      },
              methods: [:avatar, :rating_string, :location, :categories],
              only: [:name, :id, :address1 ,:address2, :neighborhood_id, :longitude, :latitude, :city, :zip_code, :price_range_avg, :reviews_count]
            )
  end

  def add_document(biz)
    @server.index(@name).type(:business).put( biz.id, JSON.parse(business_json(biz) ) )
    # @server.index(@name).type(:business).put( biz.id, JSON.parse(biz.to_elasticsearch_json) )
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
    must_options << {terms: { "categories.id" => c } } if c
    must_options << {terms: { "categories.main_category_id" => m } } if m

    puts "----++++++++++++-----"
    puts must_options
    puts "----++++++++++++-----"
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
  end

end