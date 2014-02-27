require 'spec_helper'

describe Vote do
  
  context "associations" do
  	it { should have_many(:review_votes) }
  end

  context "validations" do
  	it { should validate_presence_of(:name) }
  end


  context "#counts" do
  	it "returns tallies of the different votes" do
  		vote1 = create(:vote, name: "a")
  		vote2 = create(:vote, name: "b")
  		vote3 = create(:vote, name: "c")
  		user = create(:user)
  		business = create(:business)
	  	review = create(:review, business_id: business.id)
	  	create(:review_vote, review_id: review.id, user_id: user.id, vote_id: vote1.id )
	  	create(:review_vote, review_id: review.id, user_id: user.id , vote_id: vote2.id)
	  	create(:review_vote, review_id: review.id, user_id: user.id , vote_id: vote3.id)
	  	create(:review_vote, review_id: review.id, user_id: 1, vote_id: vote2.id)

	  	results = Vote.vote_counts
	  	
	  	expect(results[[review.id.to_s, vote1.id]]).to eq(1)
	  	expect(results[[review.id.to_s, vote2.id]]).to eq(2)
	  	expect(results[[review.id.to_s, vote3.id]]).to eq(1)
  	end
  end

end
