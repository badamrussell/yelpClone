# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

random_reviews = File.readlines("app/assets/images/temp/random_reviews.txt").to_a


total_businesses = Business.count
all_users = User.all

800.times do |i|
  business_id = rand(1..total_businesses)

  start_index = rand(random_reviews.length-21)


  review = Review.create!(
                  rating: rand(5)+1,
                  user_id: all_users.shuffle.last.id,
                  business_id: business_id,
                  body: random_reviews[start_index, rand(2..10)].join("\n"),
                  price_range: rand(5)
                )

  if rand(4) == 2
  ReviewCompliment.create!(  compliment_id: rand(1..11),
                            review_id: review.id,
                            user_id: rand(1..20),
                            body: Faker::Lorem.sentence
                          )
  end

  f_categories = FeatureCategory.all.shuffle[0,rand(1..8)]

  f_categories.each do |category|
    features = Feature.where(feature_category_id: category.id)
    feat_cnt = rand(features.length / 2)
    features = features.shuffle[0,feat_cnt]

    features.each do |feat|
      feat = features.shuffle!.pop

      val = if category.input_type == 1
        (rand(2) == 1 ? true : false)
      else
        true
      end

      BusinessFeature.create!(business_id: business_id, feature_id: feat.id, value: true, review_id: review.id)
    end

  end
end
