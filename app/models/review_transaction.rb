class ReviewTransaction

  def initialize(review, current_user)
    @transaction_errors = []
    @current_user = current_user
    @review = review
  end

  
  def perform(review_values, active_features, new_photos)
    features_delete = get_delete_features(@review.business_features, active_features)
    existing_features = @review.business_features.pluck(:feature_id).to_set

    @review.transaction do
      @review.update_attributes!(review_values) if review_values

      features_delete.each { |f| f.destroy }
      
      active_features.each do |key, value|
        single_feature = (existing_features.include?(key) ? update_feature(key, value, @review.business_id) : create_feature(key, value, @review.business_id))

        @transaction_errors += single_feature.errors.full_messages
      end

      save_photo(new_photos)
      
      @review.save

      @transaction_errors += @review.errors.full_messages
    end
  end

  def errors
    @transaction_errors
  end


  private

  def save_photo(new_photos)
    if new_photos && !new_photos[:file].blank?
      new_photos[:business_id] = @review.business_id
      new_photos[:review_id] = @review.id

      newPhoto = @current_user.photos.build(new_photos)

      newPhoto.save
      @transaction_errors += newPhoto.errors.full_messages
    end
  end

  def get_delete_features(business_features, active_features)
    features_delete_id = business_features.pluck(:feature_id) - active_features.keys
    business_features.where(feature_id: features_delete_id)
  end

  def update_feature(key, value, business_id)
    single_feature = @review.business_features.where(feature_id: key, business_id: business_id)[0]
    single_feature.update_attributes(value: value)
    single_feature
  end

  def create_feature(key, value, business_id)
    @review.business_features.build(feature_id: key, business_id: business_id, value: value)
  end

end
