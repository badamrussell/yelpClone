require 'spec_helper'

describe Business do
  
  context "associations" do
  	it { should have_many(:reviews) }
  	it { should have_many(:features) }
  	it { should have_one(:top_review) }
  end

  context "validations" do
  	it { should validate_presence_of(:name) }
  end

	# context "rating" do
 #  	it "is average of all reviews" do
 #  		# user = create(:user)
	# 		business = create(:business)
	# 		review1 = create(:review, rating: 1, body: "awful", business_id: business.id, user_id: 1)
	# 		review2 = create(:review, rating: 4, body: "yuck", business_id: business.id, user_id: 1)
 #  		expect(business.rating_avg).to eq(2.5)
 #  	end

 #  	it "is 0 after all reviews are destroyed" do
 #  		# user = create(:user)
	# 		business = create(:business)
	# 		review1 = create(:review, rating: 1, body: "awful", business_id: business.id)
	# 		review2 = create(:review, rating: 2, body: "yuck", business_id: business.id)
	# 		business.reviews.destroy_all
 #  		expect(business.rating_avg).to eq(0)
 #  	end
 #  end

 #  context "#highlighted_reviews" do
 #  	it "returns most-complimented reviews" do
 #  		# user = create(:user)
	# 		business = create(:business)
	# 		review1 = create(:review, rating: 1, body: "awful", business_id: business.id)
	# 		review2 = create(:review, rating: 2, body: "yuck", business_id: business.id)
	# 		compliment = create(:review_compliment, compliment_id: 1, review_id: review1.id)
 #  		expect(business.get_highlight_reviews(1)[0]).to eq(review1)
 #  	end
 #  end

  # context "#recent" do
  # 	it "returns recent businesses" do
  # 		businesses = [create(:business),create(:business),create(:business)]
  # 		expect(Business.recent(2)).to eq(businesses[-2,2])
	 #  end
  # end

  # context "#has_hours?" do
  # 	it "is closed at this hour" do
  # 		business = create(:business)
  # 		expect(business.is_open?).to be_false
  # 	end

  # 	it "is open at this hour" do
  # 		business = create(:business)
  # 		expect(business.is_open?).to be_true
  # 	end
  # end

  # pending "location" do
  	
  # end

  context "with photos" do
  	it { should have_many(:photos) }
  	it { should belong_to(:store_front_photo) }
  	it { should have_many(:photo_details) }

  	it "has the most-voted photo as avatar" do
  		# business = create(:business)
  		business = Business.create(name: "Yucky Diner", country_id: 1)
  		photo1 = create(:photo, business_id: business.id)
  		photo2 = create(:photo, business_id: business.id)
  		photoDetail = create(:photo_detail, photo_id: photo1.id, store_front: true)

  		puts "RSPEC STOREID: #{business.id}: #{business}"
  		p business
  		expect(business.avatar).to eq(photo1.url)
  	end

  	it "has default image" do
  		business = create(:business)

  		expect(business.avatar).to eq("/assets/default_house.jpg")
  	end
  end

  # pending "with categories" do
  # 	# it { should have_many(:categories) }
  # 	it "have the correct categories" do

  # 	end
  # end
end
