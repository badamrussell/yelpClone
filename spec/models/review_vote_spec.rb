require 'spec_helper'

describe ReviewVote do
  
  context "associations" do
  	it { should belong_to(:review) }
  	it { should belong_to(:user) }
  	it { should belong_to(:vote) }
  end

  context "validations" do
  	it { should validate_presence_of(:review_id) }
  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:vote_id) }
  end

  before(:each) do
    setup_factories
  end

  let(:user) { User.first }
  let(:business) { create(:business) }
  let(:review) { create(:review, business_id: business.id) }
  # let(:review_vote) { create(:review_vote, review_id: review.id, user_id: user.id ) }

  context "unique review_id/user_id/vote_id combination" do
    it "duplicate entry raises error" do
      create(:review_vote, review_id: review.id, user_id: user.id, vote_id: Vote.first.id )

      review_vote2 = ReviewVote.new(review_id: review.id, user_id: user.id, vote_id: Vote.first.id)
      expect { review_vote2.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Vote has already been taken")
    end
  end


  context "#toggle" do
  	it "returns correct action" do
	  	create(:review_vote, review_id: review.id, user_id: user.id )

	  	expect(ReviewVote.toggle(user, review.id, 1)).to be(-1)
  	end
  end
end
