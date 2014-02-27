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
      business = create(:business)

      expect(business.avatar).to eq("/assets/default_house.jpg")
    end
  end

  context "#store_fronts" do
    it "returns correct number of photos in order" do
      business = create(:business)

      photo1 = create(:photo, business_id: business.id, store_front_count: 0)
      photo2 = create(:photo, business_id: business.id, store_front_count: 3)
      photo3 = create(:photo, business_id: business.id, store_front_count: 2)

      expect(business.store_fronts(3)).to eq([photo2, photo3, photo1])
    end
  end


  context "#highlighted_reviews" do
  	it "returns best-rated reviews" do
  		# user = create(:user)
			business = create(:business)
			review1 = create(:review, rating: 2, body: "awful", business_id: business.id)
			review2 = create(:review, rating: 1, body: "yuck", business_id: business.id)
      review3 = create(:review, rating: 3, body: "bleh", business_id: business.id)
   #    compliment = create(:review_compliment, compliment_id: 1, review_id: review3.id)
			# compliment = create(:review_compliment, compliment_id: 1, review_id: review1.id)
   #    compliment = create(:review_compliment, compliment_id: 1, review_id: review3.id)

  		expect(business.reload.get_highlight_reviews(3)).to eq([review3, review1, review2])
  	end
  end

  context "#recent" do
  	it "returns recently added businesses" do
  		businesses = [create(:business),create(:business),create(:business)]
  		expect(Business.recent(3)).to eq(businesses.reverse)
	  end
  end

  context "#has_hours?" do
  	it "is closed at this hour" do
  		business = create(:business)
      # business.add_hour()
  		expect(business.is_open?).to be_false
  	end

  	it "is open at this hour" do
  		business = create(:business)
      date = Time.new
      business.add_hour(date.wday, date.hour-2, date.hour+2)
  		expect(business.is_open?).to be_true
  	end
  end

  context "#categories" do
  	# it { should have_many(:categories) }

  	it "have the correct categories" do
      c1 = create(:category, name: "a")
      c2 = create(:category, name: "b")
      c3 = create(:category, name: "c")
      business = Business.create(name: "Terrible Restaurant", country_id: 1, category_ids: [c1.id,c2.id,c3.id])

      expect(business.categories.pluck(:id)).to eq([c1.id,c2.id,c3.id]) 
  	end
  end

  # pending "location" do
    
  # end
end
