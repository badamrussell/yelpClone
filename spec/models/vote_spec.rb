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
  		setup_factories

      vote1 = create(:vote, name: "a")
  		vote2 = create(:vote, name: "b")
  		vote3 = create(:vote, name: "c")
  		user1 = User.first
      user2 = create(:user, email: "a@b.com")
      user3 = create(:user, email: "b@b.com")

  		business = create(:business)
	  	review = create(:review, business: business, user: user2)
	  	create(:review_vote, review: review, user: user1, vote_id: vote1.id )
	  	create(:review_vote, review: review, user: user1, vote_id: vote2.id)
	  	create(:review_vote, review: review, user: user1, vote_id: vote3.id)
	  	create(:review_vote, review: review, user: user3, vote_id: vote2.id)

	  	results = Vote.vote_counts
	  	
	  	expect(results[[review.id.to_s, vote1.id]]).to eq(1)
	  	expect(results[[review.id.to_s, vote2.id]]).to eq(2)
	  	expect(results[[review.id.to_s, vote3.id]]).to eq(1)
  	end
  end

end
