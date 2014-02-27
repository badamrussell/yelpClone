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

  context "updates REVIEW" do
  	let(:business) { create(:business) }
  	# let(:review1) { create(:review) }

  	it "to add business_feeatures" do
  		bf_count = BusinessFeature.count
  		review1 = create(:review, rating: 1, body: "awful", business_id: business.id)
  		feature1 = create(:business_feature, business_id: business.id, review_id: review1.id)
  		feature2 = create(:business_feature, business_id: business.id, review_id: review1.id, feature_id: 4)

  		# review1.destroy
  		expect(review1.business_features.count).to eq(2)
  	end

  	it "destroy if review is destroyed" do
  		bf_count = BusinessFeature.count
  		review1 = create(:review, rating: 1, body: "awful", business_id: business.id)
  		feature1 = create(:business_feature, business_id: business.id, review_id: review1.id)
  		feature2 = create(:business_feature, business_id: business.id, review_id: review1.id, feature_id: 4)
  		review1.destroy
  		expect(BusinessFeature.count).to eq(bf_count)
  	end

  end
end
