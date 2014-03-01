require 'spec_helper'

describe Business do
  
  context "associations" do
  	it { should have_many(:reviews) }
  	it { should have_many(:features) }
  	it { should have_one(:top_review) }

    it { should have_many(:photos) }
    it { should belong_to(:store_front_photo) }
    it { should have_many(:photo_details) }

  end

  context "validations" do
  	it { should validate_presence_of(:name) }
  end

  context "#avatar" do
    it "has default image" do
      setup_factories
      business = create(:business)

      expect(business.avatar).to eq("/assets/default_house.jpg")
    end
  end

  context "#store_fronts" do
    it "returns correct number of photos in order" do
      setup_factories
      business = create(:business)

      photo1 = create(:photo, business_id: business.id, store_front_count: 0, user: User.first)
      photo2 = create(:photo, business_id: business.id, store_front_count: 3, user: User.first)
      photo3 = create(:photo, business_id: business.id, store_front_count: 2, user: User.first)

      expect(business.store_fronts(3)).to eq([photo2, photo3, photo1])
    end
  end


  context "#highlighted_reviews" do
  	it "returns best-rated reviews" do
      setup_factories
  		user = User.first
			business = create(:business)
			review1 = create(:review, rating: 2, body: "awful", business: business, user: user)
			review2 = create(:review, rating: 1, body: "yuck", business: business, user: user)
      review3 = create(:review, rating: 3, body: "bleh", business: business, user: user)
   #    compliment = create(:review_compliment, compliment_id: 1, review_id: review3.id)
			# compliment = create(:review_compliment, compliment_id: 1, review_id: review1.id)
   #    compliment = create(:review_compliment, compliment_id: 1, review_id: review3.id)

  		expect(business.reload.get_highlight_reviews(3)).to eq([review3, review1, review2])
  	end
  end

  context "#recent" do
  	it "returns recently added businesses" do
      setup_factories
  		businesses = [create(:business),create(:business),create(:business)]
  		expect(Business.recent(3)).to eq(businesses.reverse)
	  end
  end

  context "#has_hours?" do
  	it "is closed at this hour" do
      setup_factories
  		business = create(:business)
      # business.add_hour()
  		expect(business.is_open?).to be_false
  	end

  	it "is open at this hour" do
      setup_factories
  		business = create(:business)
      date = Time.new
      business.add_hour(date.wday, date.hour-2, date.hour+2)
  		expect(business.is_open?).to be_true
  	end
  end

  context "#categories" do
  	# it { should have_many(:categories) }

  	it "have the correct categories" do
      setup_factories
      c1 = create(:category, name: "a", main_category: MainCategory.first)
      c2 = create(:category, name: "b", main_category: MainCategory.first)
      c3 = create(:category, name: "c", main_category: MainCategory.first)
      business = Business.create(name: "Terrible Restaurant", country_id: 1, category_ids: [c1.id,c2.id,c3.id])

      expect(business.categories.pluck(:id)).to eq([c1.id,c2.id,c3.id]) 
  	end
  end

  # pending "location" do
    
  # end
end
