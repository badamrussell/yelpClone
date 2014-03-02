require 'spec_helper'

describe BusinessFeature do
  context "associations" do
  	it { should belong_to(:business) }
  	it { should belong_to(:feature) }
  	it { should belong_to(:review) }
  end

  context "validations" do
  	it { should validate_presence_of(:business_id) }
  	it { should validate_presence_of(:feature_id) }
  	it { should validate_presence_of(:review) }
  	# it { should validate_uniqueness_of(:feature_id) }
  	# it { should validate_uniqueness_of(:review_id) }
  end

  before(:each) do
    setup_factories
  end

  let(:business) { Business.create(name: "terrible truckstop", country_id: 1) } 
  let(:review1) { create(:review) }

  context "unique feature_id/review_id combination" do
    it "duplicate entry raises error" do
      feature1 = BusinessFeature.create(business_id: business.id, review_id: review1.id, feature_id: 1, value: true)
      feature2 = BusinessFeature.new(business_id: business.id, review_id: review1.id, feature_id: 1, value: true)
      
      expect { feature2.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Feature has already been taken")
    end
  end

  context "updates REVIEW" do
  	
  	it "to add business_feeatures" do
  		feature1 = create(:business_feature, business_id: business.id, review_id: review1.id)
  		feature2 = create(:business_feature, business_id: business.id, review_id: review1.id, feature_id: 4)

  		expect(review1.business_features.count).to eq(2)
  	end

  	it "destroy if review is destroyed" do
  		feature1 = create(:business_feature, business_id: business.id, review_id: review1.id)
  		feature2 = create(:business_feature, business_id: business.id, review_id: review1.id, feature_id: 4)
  		review1.destroy
  		expect(BusinessFeature.count).to eq(0)
  	end

  end
end
