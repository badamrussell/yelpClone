class ReviewFull

  attr_accessor :review, :business, :photo, :business_features, :review_features, :errors

  def self.create_review(current_user, params)
    new_review = ReviewFull.new(current_user)

    new_review.instance_eval do
      @review = current_user.reviews.new(params[:review])
      @business = review.business
      @photo = review.photos.first
      @photo_params = params[:photo]

      @business_features = make_business_features(params[:feature_ids])
      @review_features = make_review_features(business_features)
    end

    new_review
  end

  def self.update_review(current_user, params, is_update=false)
    new_review = ReviewFull.new(current_user)

    new_review.instance_eval do
      @review = Review.find(params[:id])
      @business = review.business
      @photo = review.photos.first || Photo.new
      @photo_params = params[:photo]

      @business_features = is_update ? make_business_features(params[:feature_ids]) : review.completed_biz_features
      @review_features = make_review_features(business_features)
    end

    new_review
  end

  def self.new_review(current_user, params)
    new_review = ReviewFull.new(current_user)

    new_review.instance_eval do
      @review = Review.new
      @business = Business.find(params[:business_id])
      @photo = Photo.new

      @business_features = {}
      @review_features = make_review_features(business_features)
    end

    new_review
  end

  def initialize(current_user)    
    @errors = []
    @current_user = current_user
  end

  def perform_transaction(review_values)
    features_delete = get_delete_features
    existing_features = @review.business_features.pluck(:feature_id).to_set

    @review.transaction do
      @review.update_attributes!(review_values) if review_values

      features_delete.each { |f| f.destroy }
      
      business_features.each do |key, value|
        single_feature = (existing_features.include?(key) ? update_feature(key, value) : create_feature(key, value))

        @errors += single_feature.errors.full_messages
      end

      save_photo(@photo_params)
      
      @review.save

      @errors += @review.errors.full_messages
    end
  end



  private

  def make_business_features(features)

    feats = {}
    if features
      features.each do |k,v|
        if !!v == v
          feats[k.to_i] = v
        elsif k.to_i == 0
          feats[v.to_i] = true
        else
          feats[k.to_i] = v == "1"
        end
      end
    end

    feats
  end

  def make_review_features(set)

    features = []

    FeatureCategory.quick_all.first.features.each do |feature|
      choices = []

      choices << feature.name

      check_value = set[feature.id].nil? ? nil : set[feature.id]

      choices << {   type: "radio",
                      name: "feature_ids[#{feature.id}]",
                      id: "feature_ids_#{feature.id}_Yes",
                      value: "1",
                      content: "Yes",
                      checked: check_value
                  }
      choices << {   type: "radio",
                      name: "feature_ids[#{feature.id}]",
                      id: "feature_ids_#{feature.id}_No",
                      value: "0",
                      content: "No",
                      checked: check_value == false
                  }
      choices << {   type: "radio",
                      name: "feature_ids[#{feature.id}]",
                      id: "feature_ids_#{feature.id}_nil",
                      value: nil,
                      content: "Not Sure"
                  }

      features << choices
    end


    FeatureCategory.quick_all.each do |feature|
      next if feature.id == 1
      choices = []

      choices << feature.name

      f_type = (feature.input_type == 1 ? "radio" : "checkbox")
      f_name = (feature.input_type == 1 ? nil : feature.name)
      f_value = (feature.input_type == 1 ? nil : "1")
      f_id = (feature.input_type == 1 ? feature.name : nil)

      feature.features.each do |f|
        temp_name = f_name || f.name
        temp_value = f_value || f.id
        temp_id = f_id || f.id

        choices << {  type: f_type,
                      name: "feature_ids[#{temp_id}]",
                      id: "feature_ids_#{ temp_id }_#{ temp_name }",
                      value: temp_value,
                      content: f.name,
                      checked: set.keys.include?(f.id)
                    }

      end

      if f_type == "radio"
        choices << {   type: "radio",
                        name: "feature_ids[#{f_id}]",
                        id: "feature_ids_#{f_id}_nil",
                        value: nil,
                        content: "Not Sure"
                    }
      end

      features << choices
    end

    features
  end

  def save_photo(new_photos)
    if new_photos && !new_photos[:file].blank?
      new_photos[:business_id] = business.id
      new_photos[:review_id] = @review.id

      @photo = @current_user.photos.build(new_photos)

      @photo.save
      @errors += @photo.errors.full_messages
    end
  end

  def get_delete_features
    features_delete_id = @review.business_features.pluck(:feature_id) - business_features.keys
    @review.business_features.where(feature_id: features_delete_id)
  end

  def update_feature(key, value)
    single_feature = @review.business_features.where(feature_id: key, business_id: business.id)[0]
    single_feature.update_attributes(value: value)
    single_feature
  end

  def create_feature(key, value)
    @review.business_features.build(feature_id: key, business_id: business.id, value: value)
  end

end
