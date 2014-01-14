module ReviewsHelper

  def format_features(features)
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

  def makeFeatures(params = nil)
    set = format_features(params)

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
end
