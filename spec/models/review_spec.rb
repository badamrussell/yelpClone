require 'spec_helper'

describe Review do
  
  context "associations" do
		it { should belong_to(:user) }
		it { should belong_to(:business) }
		it { should have_many(:photos) }
		it { should have_many(:business_features) }
		it { should have_many(:review_votes) }
		it { should have_many(:votes) }
		it { should have_many(:review_compliments) }
		it { should have_many(:compliments) }
		it { should have_many(:list_reviews) }
		it { should have_many(:lists) }
	end

	context "validations" do
		it { should validate_presence_of(:rating) }
		it { should validate_presence_of(:user_id) }
		it { should validate_presence_of(:business) }
		it { should validate_presence_of(:body).with_message("Review cannot be blank!") }
	end

	context "updates BUSINESS rating" do
		let(:business) { create(:business) }
  	# let(:review1) { create(:review, rating: 1, body: "awful", business: business) }

  	it ".reviews_count increases" do
      setup_factories
      user = User.first
			review1 = create(:review, rating: 1, body: "awful", business: business, user: user)
			expect(business.reload.reviews_count).to eq(1)
  	end

  	it ".reviews_count decreases" do
      setup_factories
      user = User.first
			review1 = create(:review, rating: 1, body: "awful", business: business, user: user)
			business.reload.reviews.destroy_all
			expect(business.reload.reviews_count).to eq(0)
  	end

  	it "rating_avg is average of all reviews" do
      setup_factories
      user = User.first
			review1 = create(:review, rating: 1, body: "awful", business: business, user: user)
			review2 = create(:review, rating: 4, body: "yuck", business: business, user: user)
  		expect(business.reload.rating_avg).to eq(2.5)
  	end

  	it "rating_avg adjusts after a review is destroyed" do
      setup_factories
      user = User.first
			review1 = create(:review, rating: 1, body: "awful", business: business, user_id: 1, user: user)
			review1.destroy
			review2 = create(:review, rating: 4, body: "yuck", business: business, user_id: 1, user: user)
  		expect(business.reload.rating_avg).to eq(4)
  	end

  	it "rating_avg to 0 after all reviews are destroyed" do
  		# user = create(:user)
      setup_factories
      user = User.first
			review1 = create(:review, rating: 1, body: "awful", business: business, user: user)
			review2 = create(:review, rating: 2, body: "yuck", business: business, user: user)
			business.reload
      # puts "COUNT B: #{business.reviews.count} : #{business.reviews_count}"
			business.reviews.destroy_all
			business.reload
      # puts "COUNT A: #{business.reviews.count} : #{business.reviews_count}"
  		expect(business.rating_avg).to eq(0)
  	end
  end

  context "updates BUSINESS price_range" do
		let(:business) { create(:business) }

		it ".price_range reflects one review" do
      setup_factories
      user = User.first
			review1 = create(:review, rating: 1, body: "awful", business: business, price_range: 4, user: user)

			expect(business.reload.price_range_avg).to eq(4)
		end

		it ".price_range reflects average" do
      setup_factories
      user = User.first
			review1 = create(:review, rating: 1, body: "awful", business: business, price_range: 4, user: user)
			review2 = create(:review, rating: 1, body: "awful", business: business, price_range: 1, user: user)

			expect(business.reload.price_range_avg).to eq(2)
		end

		it ".price_range adjusts after destroy" do
      setup_factories
      user = User.first
			review1 = create(:review, rating: 1, body: "awful", business: business, price_range: 4, user: user)
			review2 = create(:review, rating: 1, body: "awful", business: business, price_range: 1, user: user)
			review1.destroy

			expect(business.reload.price_range_avg).to eq(1)
		end

		it ".price_range is 0 after all are deleted" do
      setup_factories
      user = User.first
			review1 = create(:review, rating: 1, body: "awful", business: business, price_range: 4, user: user)
			review2 = create(:review, rating: 1, body: "awful", business: business, price_range: 1, user: user)
			business.reviews.destroy_all

			expect(business.reload.price_range_avg).to eq(0)
		end
  end

  context "#snippet truncates text" do
		let(:business) { create(:business) }
  	it "should leave short reviews alone " do
      setup_factories
      user = User.first
	  	review1 = create(:review, rating: 1, body: "awful", business: business, price_range: 4, user: user)
	  	expect(review1.snippet).to eq("awful")
	  end

	  it "truncates text" do
      setup_factories
      user = User.first
	  	review1 = create(:review, rating: 1, body: "awfullawful", business: business, price_range: 4, user: user)
	  	expect(review1.snippet(10)).to eq("awfullawfu...")
	  end
  end
end