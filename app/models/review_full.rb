class ReviewFull
  SIMPLE_CHOICES = [{id: "Yes", value: "1", content: "Yes"}, 
                    {id: "No", value: "0", content: "No"}, 
                    {id: "nil", value: nil, content: nil}
                  ]
  
  attr_accessor :review, :business, :photo, :business_features, :review_features, :errors

  def self.create_review(current_user, params)
    ReviewFull.new(current_user.reviews.new(params[:review]), current_user, params)
  end

  def self.update_review(current_user, params, is_update=false)
    if is_update
      ReviewFull.new(Review.find(params[:id]), current_user, params)
    else
      ReviewFull.new(Review.find(params[:id]), current_user, params, nil, review.completed_biz_features)
    end
  end

  def self.new_review(current_user, params)
    ReviewFull.new(Review.new, current_user, params, Business.find(params[:business_id]))
  end

  def initialize(review, current_user, params, business=nil, biz_features=nil)  
    @review = review

    @business = (business ? business : @review.business)
    @photo = review.photos.first || Photo.new
    @photo_params = params[:photo]

    @business_features = (biz_features ? biz_features : make_business_features(params[:feature_ids]))
    @review_features = setup_review_choices(business_features)

    @errors = []
    @current_user = current_user
  end

  def perform_transaction(review_values)
    @review.transaction do
      @review.update_attributes!(review_values) if review_values

      remove_missing_features

      update_existing_features

      save_photo(@photo_params)
      
      @review.save

      @errors += @review.errors.full_messages
    end
  end



  private

  def remove_missing_features
    get_delete_features.each { |f| f.destroy }
  end

  def update_existing_features
    existing_features = @review.business_features.pluck(:feature_id).to_set

    business_features.each do |key, value|
      single_feature = (existing_features.include?(key) ? update_feature(key, value) : create_feature(key, value))

      @errors += single_feature.errors.full_messages
    end
  end
  
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

  def setup_boolean_features(set)
    FeatureCategory.quick_all.first.features.map do |feature|
      check_value = set[feature.id].nil? ? nil : set[feature.id]

      [feature.name] + SIMPLE_CHOICES.map do |c|
        {  type: "radio",
            name: "feature_ids[#{feature.id}]",
            id: "feature_ids_#{feature.id}_#{c.id}",
            value: c.value,
            content: c.content,
            checked: check_value
        }
      end
    end
  end

  def setup_checkbox_choices(feature, set)
    f_type, f_name, f_value, f_id = if feature.input_type == 1
        ["radio", nil, nil, feature.name]
      else
        ["checkbox", feature.name, "1", nil]
      end

    feature.features.map do |f|
      temp_name = f_name || f.name
      temp_value = f_value || f.id
      temp_id = f_id || f.id

      {  type: f_type,
        name: "feature_ids[#{temp_id}]",
        id: "feature_ids_#{ temp_id }_#{ temp_name }",
        value: temp_value,
        content: f.name,
        checked: set.keys.include?(f.id)
      }
    end
  end

  def setup_checkbox_features(set)
    FeatureCategory.quick_all.map do |feature|
      next if feature.id == 1
      choices = [feature.name] + setup_checkbox_choices(feature, set)

      if feature.input_type == 1
        choices << {   type: "radio",
                        name: "feature_ids[#{feature.name}]",
                        id: "feature_ids_#{feature.name}_nil",
                        value: nil,
                        content: "Not Sure"
                    }
      end

      choices
    end
  end

  def setup_review_choices(set)
    setup_boolean_features(set) + setup_checkbox_features(set)
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
