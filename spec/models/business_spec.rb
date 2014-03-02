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

  before(:each) do
    setup_factories
  end

  subject(:business) { create(:business) }

  context "#highlighted_reviews" do
  	it "returns best-rated reviews" do
  		user = User.first

			review1 = create(:review, rating: 2, body: "awful", business: business, user: user)
			review2 = create(:review, rating: 1, body: "yuck", business: business, user: user)
      review3 = create(:review, rating: 3, body: "bleh", business: business, user: user)

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
  		expect(business.is_open?).to be_false
  	end

  	it "is open at this hour" do
      date = Time.new
      business.add_hour(date.wday, date.hour-2, date.hour+2)
  		expect(business.is_open?).to be_true
  	end
  end

end
